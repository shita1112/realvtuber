# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
