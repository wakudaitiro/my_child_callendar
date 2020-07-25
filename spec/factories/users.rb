FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "testuser_#{n}" }
    sequence(:babyname) { |n| "testbaby_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "testuser" }
  end
  # usernameがないもの
  factory :invalid_user, class: User do
    sequence(:babyname) { |n| "testbaby_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "testuser" }
  end
end
