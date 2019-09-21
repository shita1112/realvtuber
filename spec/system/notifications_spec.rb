# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Notifications", type: :system do
  include_context "sign in"
  let!(:work) { create(:work, user: current_user) }
  before { create(:notification, work: work) }

  describe "show a notification" do
    before do
      visit root_path
      click_on("動画作成が完了しました。")
    end

    it 'shows "動画のダウンロード"' do
      expect(page).to have_content "動画のダウンロード"
    end
  end

  describe "update a notification" do
    before do
      visit root_path
      click_on("全ての通知を既読にする")
    end

    it 'shows "全ての通知を既読にしました。"' do
      expect(page).to have_content "全ての通知を既読にしました。"
    end
  end
end
