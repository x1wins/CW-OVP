require 'rails_helper'

RSpec.describe "encodes/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @title = "hello"
    @encode = assign(:encode, Encode.create!(title: @title, user: @user, file: FactoryHelpers.upload_file('spec/factories/sample.mp4', 'video/mp4', true)))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match @title
    expect(rendered).to match @user.email
  end
end
