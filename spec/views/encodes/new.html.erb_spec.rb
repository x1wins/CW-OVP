require 'rails_helper'

RSpec.describe "encodes/new", type: :view do
  before(:each) do
    assign(:encode, Encode.new())
  end

  it "renders new encode form" do
    render

    assert_select "form[action=?][method=?]", encodes_path, "post" do
    end
  end
end
