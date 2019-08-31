# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :work

  delegate :user, to: :work

  scope :unread, -> { where(read: false) }
end
