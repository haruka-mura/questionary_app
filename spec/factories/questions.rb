FactoryBot.define do
  factory :question do
    subject {"sample question"}
    content {"something to ask"}
    state {'accepting'}
    association :user
  end
end
