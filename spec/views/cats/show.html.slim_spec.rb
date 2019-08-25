# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cats/show", type: :view do
  before do
    @cat = assign(:cat, Cat.create!(
                          name: "Name",
                        ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
