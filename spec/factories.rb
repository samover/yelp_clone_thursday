FactoryGirl.define do
  factory :user do
    email 'pjackson@makers.com'
    password 'password'
    password_confirmation 'password' 
  end

  factory :user2, class: User do
    email 'sam@makers.com'
    password 'password'
    password_confirmation 'password' 
  end

  factory :restaurant do
    name 'KFC'
  end
end
