# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cats/edit", type: :view do
  before do
    @cat = assign(:cat, Cat.create!(
                          name: "MyString",
                        ))
  end

  it "renders the edit cat form" do
    render

    assert_select "form[action=?][method=?]", cat_path(@cat), "post" do
      assert_select "input[name=?]", "cat[name]"
    end
  end
end
