# frozen_string_literal: true

class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :filename, null: false
      t.datetime :completed_at

      t.references :trained_model, null: false
      t.references :user, null: false

      t.string :original_video
      t.string :df_video
      t.string :comparison_video

      t.string :original_image
      t.string :df_image

      t.timestamps
    end
  end
end
