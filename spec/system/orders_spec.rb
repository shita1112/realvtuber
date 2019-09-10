# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :system do
  describe "GET /order" do
    let(:user) { create(:user) }
    before do
      sign_in(user)
      visit order_path
    end

    it "is order page" do
      expect(page).to have_content "高品質な動画を作る・顔を作る"
    end
  end
end
