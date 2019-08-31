# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @works = current_user.works
                         .completed
                         .preload(:trained_model)
                         .order(created_at: :desc)
                         .page(params[:page])

    redirect_to new_work_path unless @works.exists?
  end

  def show
    @work = Work.find(params[:id])
    authorize @work
  end

  def new
    @work = Work.new
    @trained_models = TrainedModel.all
  end

  def create
    @work = current_user.works.build(work_params)
    @work.filename = @work.original_video.filename

    if @work.save
      CreateVideosJob.perform_later(@work)
      redirect_to root_url, notice: create_message
    else
      @trained_models = TrainedModel.all
      render :new
    end
  end

  def destroy
    @work = Work.find(params[:id])
    authorize @work

    @work.destroy
    redirect_to root_url, notice: "動画を削除しました。"
  end

  private

  def work_params
    params.require(:work).permit(:original_video, :original_video_cache, :trained_model_id)
  end

  def create_message
    <<~HTML
      <p>動画作成を受け付けました。AIが動画作成を完了するのに、15分ほどかかります。完了しましたら、画面右上の通知アイコンにてお知らせいたします。</p>
    HTML
  end
end
