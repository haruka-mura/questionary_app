FactoryBot.define do
  factory :tag do
   name { "tag1 tag2 tag3" }
   association :question
  end
end
