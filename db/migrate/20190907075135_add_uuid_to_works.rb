# frozen_string_literal: true

class AddUuidToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :uuid, :string, null: false
  end
end
