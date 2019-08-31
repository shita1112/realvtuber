# frozen_string_literal: true

class TrainedModel < ApplicationRecord
  mount_uploader :face_image, FaceImageUploader

  has_many :works, dependent: :destroy

  enum trainer: { villain: 0, unbalanced: 1, realface: 2 }
end
