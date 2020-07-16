require 'rails_helper'

RSpec.describe "encodes/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @title = "hello"
    @encode = assign(:encode, Encode.create!(title: @title, user: @user, file: Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.mp4"))))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match @title
    expect(rendered).to match @user.email
  end
end
