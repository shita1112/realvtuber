# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @works = current_user.works
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
      job = CreateVideosJob.perform_later(@work)
      Delayed::Job.find(job.provider_job_id).update!(work: @work)
      redirect_to root_url, notice: render_to_string(partial: "create_message")
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
end
