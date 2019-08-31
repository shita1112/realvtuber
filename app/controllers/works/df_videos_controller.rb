# frozen_string_literal: true

class Works::DfVideosController < ApplicationController
  def show
    work = Work.find(params[:work_id])
    authorize work

    send_data work.df_video.read,
              disposition: "attachment",
              filename: "realvtuber_df_#{work.id}.mp4"
  end
end
