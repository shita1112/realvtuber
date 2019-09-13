# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  context "scopes" do
    describe ".unread" do
      let!(:user) { create(:user) }
      let!(:trained_model) { create(:trained_model) }
      let!(:work) { create(:work, user: user, trained_model: trained_model) }
      let!(:unread_notification) { create(:notification, work: work, read: false) }
      let!(:read_notification) { create(:notification, work: work, read: true) }

      it "includes unread_notifications" do
        expect(Notification.unread).to include unread_notification
      end

      it "not include read_notifications" do
        expect(Notification.unread).not_to include read_notification
      end
    end
  end
end
