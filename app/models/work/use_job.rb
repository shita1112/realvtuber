# frozen_string_literal: true

class Work
  concern :UseJob do
    JOB_QUEUE_COUNT = 3

    included do
      has_one :job, class_name: "::Delayed::Job", dependent: :destroy

      scope :failed,      -> { joins(:job).merge(::Delayed::Job.failed) }
      scope :working,     -> { joins(:job).merge(::Delayed::Job.working) }
      scope :pending,     -> { joins(:job).merge(::Delayed::Job.pending) }
      scope :unfailed,    -> { joins(:job).merge(::Delayed::Job.unfailed) }
    end

    # 0から
    def nth_job
      @nth_job ||= Work.unfailed.index(self)
    end

    def wait_minutes
      Work::TOTAL_MINUTES * (nth_job / JOB_QUEUE_COUNT + 1)
    end

    def nth_job_text
      "#{nth_job + 1}番目"
    end

    def wait_time_text
      hours, minutes = wait_minutes.divmod(60)

      text = []
      text << "#{hours}時間" if hours != 0
      text << "#{minutes}分" if minutes != 0
      text << "後"
      text.join
    end

    def nth_and_wait_time_text
      "#{nth_text}（#{wait_time_text}）"
    end

    def failed?
      Work.failed.exists?(id: id)
    end

    def working?
      Work.working.exists?(id: id)
    end

    def pending?
      Work.pending.exists?(id: id)
    end

    def unfailed?
      Work.unfailed.exists?(id: id)
    end

    def totally_failed?
      failed? || job.nil?
    end
  end
end
