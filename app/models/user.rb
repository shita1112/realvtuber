# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable

  has_many :works, dependent: :destroy
  has_many :notifications, through: :works

  enum role: { admin: 0, normal: 1 }
end
