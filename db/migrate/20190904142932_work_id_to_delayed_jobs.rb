# frozen_string_literal: true

class WorkIdToDelayedJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :delayed_jobs, :work_id, :bigint, index: true
  end
end
