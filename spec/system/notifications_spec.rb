# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let!(:user) { create(:user) }
  let!(:trained_model) { create(:trained_model) }
  let!(:work) { create(:work, trained_model: trained_model, user: user) }
  before do
    sign_in(user)
    create(:notification, work: work)
  end

  describe "show a notification" do
    it 'displays "動画のダウンロード"' do
      visit root_path
      click_on("動画作成が完了しました。")

      expect(page).to have_content "動画のダウンロード"
    end
  end

  describe "update a notification" do
    it 'displays "全ての通知を既読にしました。"' do
      visit root_path
      click_on("全ての通知を既読にする")

      expect(page).to have_content "全ての通知を既読にしました。"
    end
  end
end
