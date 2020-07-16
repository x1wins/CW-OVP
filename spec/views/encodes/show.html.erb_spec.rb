require 'rails_helper'

RSpec.describe "encodes/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @encode = assign(:encode, Encode.create!(title: "hello", user: @user, file: Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.mp4"))))
  end

  it "renders attributes in <p>" do
    render
  end
end
