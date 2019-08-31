# frozen_string_literal: true

class Works::ComparisonVideosController < ApplicationController
  def show
    work = Work.find(params[:work_id])
    authorize work

    send_data work.comparison_video.read,
              disposition: "attachment",
              filename: "realvtuber_comparison_#{work.id}.mp4"
  end
end
