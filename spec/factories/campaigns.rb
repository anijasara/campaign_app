FactoryBot.define do
  factory :campaign do
    external_reference { "MyString" }
    description { "MyText" }
    status { false }
  end
end
