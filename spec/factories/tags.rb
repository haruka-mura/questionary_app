FactoryBot.define do
  factory :tag do
   name { "tag1" }

     before(:create) do |tag|
       create_list(:question, 1, tags: [tag])
     end
  end
end
