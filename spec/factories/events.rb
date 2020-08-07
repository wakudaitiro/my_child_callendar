FactoryBot.define do
  factory :event do
    start { '2020-07-26 22:00:00' }
    add_attribute(:end) { '2020-07-26 23:30:00' }
    color { 'gray' }
    icon { 'milk.png' }
  end

  factory :update_event, class: Event do
    association :user
    start { '2020-07-27 22:00:00' }
    add_attribute(:end) { '2020-07-27 23:30:00' }
    color { 'gray' }
    icon { 'milk.png' }
  end

  factory :event_user, class: User do
    username { 'event_user' }
    babyname { 'event_baby' }
    email { 'event_test@example.com' }
    password { 'testuser1' }
  end
end
