FactoryBot.define do
  factory :answer do
    comment {"sample comment"}
    association :user
    association :question
  end
end
