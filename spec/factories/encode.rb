# spec/factories/user.rb
FactoryBot.define do
  factory :encode do
    title { Faker::Ancient.god }
    file { FactoryHelpers.upload_file('spec/factories/sample.mp4', 'video/mp4', true) }
    user  { create(:user) }
  end
end