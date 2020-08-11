FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "testuser_#{n}" }
    sequence(:babyname) { |n| "testbaby_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'testuser' }
  end

  factory :noname_user, class: User do
    sequence(:babyname) { |n| "testbaby_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'testuser' }
  end

  factory :login_user, class: User do
    username { 'login_user' }
    babyname { 'login_baby' }
    email { 'login_test@example.com' }
    password { 'testuser1' }
  end
end
