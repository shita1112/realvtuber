# frozen_string_literal: true

class FaceImageUploader < ApplicationUploader
  process convert: "jpeg",
          resize_to_fill: [150, 150]

  def extension_whitelist
    %w[jpeg jpg png]
  end

  def filename
    super.chomp(File.extname(super)) + ".jpeg" if original_filename.present?
  end
end
