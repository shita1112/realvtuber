# frozen_string_literal: true

Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 15
Delayed::Worker.max_attempts = 2
