# spec/factories/user.rb
FactoryBot.define do
  factory :encode do
    title { Faker::Ancient.god }
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.mp4")) }
    user  { create(:user) }
  end
end