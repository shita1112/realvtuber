# frozen_string_literal: true

RSpec.shared_context "sign in" do
  let!(:current_user) { create(:user) }
  before { sign_in(current_user) }
end

RSpec.shared_context "sign in as admin" do
  let!(:current_user) { create(:user, :admin) }
  before { sign_in(current_user) }
end

RSpec.shared_context "sign out" do
  let!(:current_user) { create(:user) }
  before { sign_out(current_user) }
end
