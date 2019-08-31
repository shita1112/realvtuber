# frozen_string_literal: true

class AddNotNullConstraintToWorksOriginalVideo < ActiveRecord::Migration[6.0]
  def change
    change_column_null :works, :original_video, false
  end
end
