# frozen_string_literal: true

class Work
  module CreateVideos
    include Rake::FileUtilsExt

    # 通常動画はお試し程度にしておいて、高品質動画は別で用意する
    TRAIN_TIME = 15.minutes
    DETECTOR = "mtcnn"
    SAVE_INTERVAL = 50
    GPUS = 1

    def create_videos
      setup

      extract
      train
      convert
      merge_videos

      cleanup
    end

    private

    def setup
      set_pathname
      clean_dir
      mkdirs
      copy_models
      download_video
    end

    def set_pathname
      @deep_root             = Rails.root.dirname
      @font                  = @deep_root.join("unifont-11.0.01.ttf")
      @works                 = @deep_root.join("works")
      @work                  = @works.join("work_#{id}")
      @original_models       = @deep_root.join("model_image", trained_model.name, "#{trained_model.trainer}_models")
      @b_faces               = @deep_root.join("model_image", trained_model.name, "images")
      @models                = @work.join("models")
      @a_images              = @work.join("a_images")
      @a_faces               = @work.join("a_faces")
      @df                    = @work.join("df")
      @comparison            = @work.join("comparison")
      @original_video        = @work.join("realvtuber_original.mp4")
      @df_video_pre          = @work.join("realvtuber_df_pre.mp4")
      @df_video              = @work.join("realvtuber_df.mp4")
      @comparison_video_pre  = @work.join("realvtuber_comparison_pre.mp4")
      @comparison_video      = @work.join("realvtuber_comparison.mp4")
    end

    def clean_dir
      @work.rmtree if @work.exist?
    end

    def mkdirs
      mkdir(@work)
      mkdir(@a_images)
      mkdir(@a_faces)
      mkdir(@df)
      mkdir(@comparison)
    end

    def copy_models
      cp_r(@original_models, @models)
    end

    def download_video
      video = open(original_video.url).read
      File.write(@original_video, video, mode: "wb")
    end

    def extract
      split_video
      faceswap_extract
    end

    def split_video
      FaceswapPy.effmpeg(
        "--action", "extract",
        "--input", @original_video,
        "--output", @a_images,
        "--fps", "25"
      )
    end

    def faceswap_extract
      FaceswapPy.extract(
        "--input-dir", @a_images,
        "--output-dir", @a_faces,
        "--detector", DETECTOR,
        "--skip-existing",
        "--skip-existing-faces"
      )
    end

    def train
      set_batch_size
      train_model
    end

    def set_batch_size
      face_count = Dir[@a_faces + "*"].size

      case
      when trained_model.villain?
        @batch_size = case face_count
                      when 0        then raise "no face image"
                      when 1..2     then 1
                      when 3..16    then 2
                      when 17..32   then 8
                      when 33..64   then 16
                      when 65..     then 24
                      end
      when trained_model.unbalanced?
        @batch_size = case face_count
                      when 0        then raise "no face image"
                      when 1..2     then 1
                      when 3..16    then 2
                      when 17..32   then 8
                      when 33..64   then 16
                      when 65..80   then 32
                      when 81..     then 55
                      end
      end
    end

    def train_model
      puts "start train"
      FaceswapPy.train_with_timeout(
        TRAIN_TIME,
        "--input-A", @a_faces,
        "--input-B", @b_faces,
        "--model-dir", @models,
        "--trainer", trained_model.trainer,
        "--batch-size", @batch_size,
        "--save-interval", SAVE_INTERVAL,
        "--gpus", GPUS
      )
    end

    def convert
      FaceswapPy.convert(
        "--model-dir", @models,
        "--input-dir", @a_images,
        "--output-dir", @df,
        "--trainer", trained_model.trainer,
        "--gpus", GPUS,
        # "--smooth-box",
        # "--avg-color-adjust",
        # "--erosion-size", "12",
        # "--blur-size", "12",
        # "--seamless",
        "--color-adjustment", "avg-color"
      )
    end

    def merge_videos
      set_merge_variables
      merge_df_video

      create_comparison_images
      merge_comparison_video
    end

    def set_merge_variables
      @original_files = Dir[@a_images.join("*.png")].sort
      @df_files = Dir[@df.join("*.png")].sort
    end

    def merge_df_video
      FaceswapPy.effmpeg(
        "--action", "gen-vid",
        "--input", @df.to_s,
        "--output", @df_video_pre,
        "--fps", "25",
        "--reference-video", @original_video,
        "--mux-audio"
      )

      system("ffmpeg -i #{@df_video_pre} -movflags faststart -pix_fmt yuv420p -strict -2 #{@df_video}")
    end

    def create_comparison_images
      @original_files.zip(@df_files).each.with_index(1) do |(original_file, df_file), i|
        MiniMagick::Tool::Montage.new do |command|
          command << "-pointsize" << "60"
          command << "-font" << @font.to_s
          command << "-label" << "オリジナル" << original_file
          command << "-label" << "リアルバーチャルYoutuber" << df_file
          command << "-background" << "white"
          command << "-geometry" << "+0+0"
          command << @comparison + ("%05d.png" % i)
        end
      end

      @comparison_files = Dir[@comparison.join("*.png")].sort
    end

    def merge_comparison_video
      FaceswapPy.effmpeg(
        "--action", "gen-vid",
        "--input", @comparison.to_s,
        "--output", @comparison_video_pre,
        "--fps", "25",
        "--reference-video", @original_video,
        "--mux-audio"
      )

      movie = FFMPEG::Movie.new(@df_video.to_s)
      system("ffmpeg -i #{@comparison_video_pre} -movflags faststart -pix_fmt yuv420p -strict -2 -vf 'scale=w=#{movie.width}:h=#{movie.height}:force_original_aspect_ratio=1,pad=#{movie.width}:#{movie.height}:(ow-iw)/2:(oh-ih)/2' #{@comparison_video}")
    end

    def cleanup
      update_self
      create_notification

      # work_rmtree # debugのため、しばらくコメントアウト
      puts_finish
    end

    def update_self
      update!(
        completed_at: Time.current,
        df_video: File.open(@df_video),
        df_image: File.open(@df_files[0]),
        comparison_video: File.open(@comparison_video),
        comparison_image: File.open(@comparison_files[0]),
      )
    end

    def create_notification
      notifications.create!
    end

    def work_rmtree
      @work.rmtree
    end

    def puts_finish
      puts "finish"
    end
  end
end
