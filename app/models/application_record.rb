# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :created_within_24h, -> { where("created_at > ?", 1.day.ago) }
end
