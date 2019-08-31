# frozen_string_literal: true

class AddReadToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :read, :boolean, default: false, null: false
  end
end
