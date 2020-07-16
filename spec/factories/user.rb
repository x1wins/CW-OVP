# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end