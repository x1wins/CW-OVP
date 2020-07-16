require 'rails_helper'

RSpec.describe "encodes/index", type: :view do
  before(:each) do
    assign(:encodes, [
      Encode.create!(),
      Encode.create!()
    ])
  end

  it "renders a list of encodes" do
    render
  end
end
