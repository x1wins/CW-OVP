require 'rails_helper'

RSpec.describe "encodes/show", type: :view do
  before(:each) do
    @encode = assign(:encode, Encode.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
