# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Dashboards", type: :system do
  describe "a link to the dashboard" do
    context "sign in as admin" do
      include_context "sign in as admin"
      before do
        visit root_path
      end

      it "has a link to the dashboard" do
        expect(page).to have_link "ダッシュボード"
      end
    end

    context "sign in as normal" do
      include_context "sign in"
      before do
        visit root_path
      end

      it "doesn't have a link to the dashboard" do
        expect(page).not_to have_link "ダッシュボード"
      end
    end
  end

  describe "show a dashboard" do
    context "sign in as admin" do
      include_context "sign in as admin"
      before do
        create(:work, created_at: 23.hours.ago, id: 10000)
        create(:work, created_at: 25.hours.ago, id: 10001)
        create(:user, created_at: 23.hours.ago, id: 10002)
        create(:user, created_at: 25.hours.ago, id: 10003)
        visit admin_dashboard_path
      end

      it 'shows "ダッシュボード"' do
        expect(page).to have_content "ダッシュボード"
      end

      it "shows work_created_before_24h" do
        expect(page).to have_content "10000"
      end

      it "doesn't show work_created_after_24h" do
        expect(page).not_to have_content "10001"
      end

      it "shows user_created_before_24h" do
        expect(page).to have_content "10002"
      end

      it "doesn't show user_created_after_24h" do
        expect(page).not_to have_content "10003"
      end
    end

    context "sign in as noarmal" do
      include_context "sign in"
      before do
        visit admin_dashboard_path
      end

      it 'shows "権限がありません。"' do
        expect(page).to have_content "権限がありません。"
      end
    end
  end
end
