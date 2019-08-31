# frozen_string_literal: true

class CreateTrainedModels < ActiveRecord::Migration[6.0]
  def change
    create_table :trained_models do |t|
      t.string :name, null: false
      t.string :display_name, null: false

      t.string :face_image, null: false

      t.timestamps
    end
  end
end
