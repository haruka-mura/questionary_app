FactoryBot.define do
  factory :user do
    name "MyString"
    sequence(:name) { |n| "みんなのウェディング#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password "TEST_PASSWORD"
    password_confirmation "TEST_PASSWORD"
  end
end
