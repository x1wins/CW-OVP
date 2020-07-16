require 'rails_helper'

RSpec.describe "encodes/edit", type: :view do
  before(:each) do
    @encode = assign(:encode, Encode.create!())
  end

  it "renders the edit encode form" do
    render

    assert_select "form[action=?][method=?]", encode_path(@encode), "post" do
    end
  end
end
