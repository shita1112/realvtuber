# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :system do
  describe "GET /order" do
    include_context "sign in"
    before { visit order_path }

    it 'shows "高品質な動画を作る・顔を作る"' do
      expect(page).to have_content "高品質な動画を作る・顔を作る"
    end
  end
end
