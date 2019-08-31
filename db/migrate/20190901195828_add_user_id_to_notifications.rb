# frozen_string_literal: true

class AddUserIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :user_id
    remove_column :notifications, :read
    add_column :notifications, :work_id, :integer, null: false, index: true
  end
end
