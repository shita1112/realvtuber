# frozen_string_literal: true

class AddComparisonImageToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :comparison_image, :string
  end
end
