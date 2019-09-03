# frozen_string_literal: true

Delayed::Job.class_eval do
  # belongs_to :work, optional: true

  scope :failed,   -> { where.not(last_error: nil) }
  scope :working,  -> { where.not(locked_at: nil).where(last_error: nil) }
  scope :pending,  -> { where(attempts: 0, locked_at: nil) }
  scope :unfailed, -> { where(last_error: nil) } # working + pending

  def reset
    update!(
      last_error: nil,
      failed_at: nil,
      attempts: 0,
      locked_by: nil,
      locked_at: nil,
    )
  end

  def argument
    gid = payload_object.job_data["arguments"][0]["_aj_globalid"]
    GlobalID::Locator.locate(gid)
  end

  def run
    Delayed::Worker.new.run(self)
  end
end
