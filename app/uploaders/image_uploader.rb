# frozen_string_literal: true

class ImageUploader < ApplicationUploader
  process convert: "jpeg",
          resize_to_fit: [400, nil]

  def extension_whitelist
    %w[jpeg jpg png]
  end

  def filename
    super.chomp(File.extname(super)) + ".jpeg" if original_filename.present?
  end
end
