FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
    frequency { Faker::Number.between(from: 0, to: 2) }
  end
end
