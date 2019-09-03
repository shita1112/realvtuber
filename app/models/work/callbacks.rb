# frozen_string_literal: true

class Work
  class Callbacks
    def before_create(work)
      work.uuid = SecureRandom.uuid
    end
  end
end
