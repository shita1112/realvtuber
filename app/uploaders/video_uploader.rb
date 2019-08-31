# frozen_string_literal: true

class VideoUploader < ApplicationUploader
  def extension_whitelist
    %w[mp4]
  end

  def size_range
    1..10.megabytes
  end
end
