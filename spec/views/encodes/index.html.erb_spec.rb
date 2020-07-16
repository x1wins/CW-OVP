require 'rails_helper'

RSpec.describe "encodes/index", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    assign(:encodes, Kaminari.paginate_array([
      Encode.create!(title: "hello", user: @user, file: Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.mp4")))
    ]).page(1))
  end

  it "renders a list of encodes" do
    render
    expect(rendered).to match /hello/
  end
end
