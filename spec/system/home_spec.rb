# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :system do
  describe "GET /" do
    context "when signed in" do
      include_context "sign in"
      before { visit root_url }

      it 'does not have "リアルバーチャルYoutuber"' do
        expect(page).not_to have_content "リアルバーチャルYoutuber"
      end
    end

    context "when signed out" do
      include_context "sign out"
      before { visit root_url }

      it 'shows "リアルバーチャルYoutuber"' do
        expect(page).to have_content "リアルバーチャルYoutuber"
      end
    end
  end

  describe "GET /contact" do
    before { visit contact_path }

    it 'shows "お問い合わせ"' do
      expect(page).to have_content "お問い合わせ"
    end
  end

  describe "GET /disclaimer" do
    before { visit disclaimer_path }

    it 'shows "免責事項"' do
      expect(page).to have_content "免責事項"
    end
  end

  describe "GET /policy" do
    before { visit policy_path }

    it 'shows "プライバシーポリシー"' do
      expect(page).to have_content "プライバシーポリシー"
    end
  end
end
