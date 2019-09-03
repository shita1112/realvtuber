# frozen_string_literal: true

class Work < ApplicationRecord
  include CreateVideos
  include UseJob

  mount_uploader :original_video, VideoUploader
  mount_uploader :df_video, VideoUploader
  mount_uploader :comparison_video, VideoUploader
  mount_uploader :original_image, ImageUploader
  mount_uploader :df_image, ImageUploader
  mount_uploader :comparison_image, ImageUploader

  paginates_per 10

  belongs_to :user
  belongs_to :trained_model
  has_many :notifications, dependent: :destroy

  validates :original_video, presence: true

  before_create Work::Callbacks.new

  scope :completed,   -> { where.not(completed_at: nil) }
  scope :uncompleted, -> { where(completed_at: nil) }

  def completed?
    completed_at?
  end
end
