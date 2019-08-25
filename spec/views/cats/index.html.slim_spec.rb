# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cats/index", type: :view do
  before do
    assign(:cats, [
      Cat.create!(
        name: "Name",
      ),
      Cat.create!(
        name: "Name",
      ),
    ])
  end

  it "renders a list of cats" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
