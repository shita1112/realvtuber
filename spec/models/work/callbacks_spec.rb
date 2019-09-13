# frozen_string_literal: true

require "rails_helper"

RSpec.describe Work::Callbacks, type: :model do
  describe "#before_create" do
    let!(:work) { Work.new }
    let!(:callback) { Work::Callbacks.new }

    it "set work.uuid" do
      expect(work.uuid).to be_nil
      callback.before_create(work)
      expect(work.uuid).to match(/[\w-]{36}/)
    end

  end
end
