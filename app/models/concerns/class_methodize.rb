# frozen_string_literal: true

concern :ClassMethodize do
  class_methods do
    def method_missing(method, *args, &block) # rubocop:disable all
      new.send(method, *args, &block)
    end
  end
end
