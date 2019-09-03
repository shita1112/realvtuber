# frozen_string_literal: true

class VideoUploader < ApplicationUploader
  def extension_whitelist
    %w[mp4 mov]
  end

  def size_range
    1..10.megabytes
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.uuid}"
  end
end
