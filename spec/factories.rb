FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "admin_#{n}@example.com"}
    first_name 'Admin'
    last_name 'User'
    password 'password'
    password_confirmation 'password'
  end
end
