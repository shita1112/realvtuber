# frozen_string_literal: true

require "rails_helper"

RSpec.describe Work, type: :model do
  context "scopes" do
    describe ".completed" do
      let!(:user) { create(:user) }
      let!(:trained_model) { create(:trained_model) }
      let!(:uncompleted_work) { create(:work, user: user, trained_model: trained_model, completed_at: nil) }
      let!(:completed_work) { create(:work, user: user, trained_model: trained_model, completed_at: Time.current) }

      it "includes completed_works" do
        expect(Work.completed).to include completed_work
      end

      it "not include uncompleted_works" do
        expect(Work.completed).not_to include uncompleted_work
      end
    end

    describe ".uncompleted" do
      let!(:user) { create(:user) }
      let!(:trained_model) { create(:trained_model) }
      let!(:uncompleted_work) { create(:work, user: user, trained_model: trained_model, completed_at: nil) }
      let!(:completed_work) { create(:work, user: user, trained_model: trained_model, completed_at: Time.current) }

      it "includes uncompleted_works" do
        expect(Work.uncompleted).to include uncompleted_work
      end

      it "not include completed_works" do
        expect(Work.uncompleted).not_to include completed_work
      end
    end
  end

  describe "#completed?" do
    context "when completed_at is nil" do
      let!(:work) { Work.new(completed_at: nil) }

      it "isn't completed" do
        expect(work).not_to be_completed
      end
    end

    context "when completed_at isn't nil" do
      let!(:work) { Work.new(completed_at: Time.current) }

      it "is completed" do
        expect(work).to be_completed
      end
    end
  end
end
