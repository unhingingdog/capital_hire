FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    phone '0221231234'
    password 'password'
    password_confirmation 'password'
  end
end
