FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.decimal(l_digits: 1) }
    brew_time { Faker::Number.between(from: 2, to: 20) }
  end
end
