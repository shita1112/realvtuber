# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :system do
  describe "GET /" do
    let(:user) { create(:user) }

    context "when logged in" do
      before do
        sign_in(user)
        visit root_url
      end

      it "isn't be landing page" do
        expect(page).not_to have_content "リアルバーチャルYoutuber"
      end
    end

    context "when logged out" do
      before do
        sign_out(user)
        visit root_url
      end

      it "is landing page" do
        expect(page).to have_content "リアルバーチャルYoutuber"
      end
    end
  end

  describe "GET /contact" do
    before { visit contact_path }

    it "is contact page" do
      expect(page).to have_content "お問い合わせ"
    end
  end

  describe "GET /disclaimer" do
    before { visit disclaimer_path }

    it "is disclaimer page" do
      expect(page).to have_content "免責事項"
    end
  end

  describe "GET /policy" do
    before { visit policy_path }

    it "is privacy policy page" do
      expect(page).to have_content "プライバシーポリシー"
    end
  end
end
