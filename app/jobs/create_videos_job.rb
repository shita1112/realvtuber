# frozen_string_literal: true

class CreateVideosJob < ApplicationJob
  queue_as :create_videos

  def perform(work)
    work.create_videos
  end
end
