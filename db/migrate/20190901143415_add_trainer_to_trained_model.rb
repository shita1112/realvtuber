# frozen_string_literal: true

class AddTrainerToTrainedModel < ActiveRecord::Migration[6.0]
  def change
    add_column :trained_models, :trainer, :integer, null: false
  end
end
