# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  context "scopes" do
    describe "unread" do
      let!(:unread_notification) { create(:notification, read: false) }
      let!(:read_notification) { create(:notification, read: true) }

      it "includes unread_notifications" do
        expect(Notification.unread).to include unread_notification
      end

      it "not include read_notifications" do
        expect(Notification.unread).not_to include read_notification
      end
    end
  end
end
