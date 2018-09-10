FactoryBot.define do
  factory :tag do
   name { "tag1" }
   association :question
  end
end
