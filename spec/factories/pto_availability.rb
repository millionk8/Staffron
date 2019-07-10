FactoryGirl.define do
  factory :pto_availability do
    user
    category
    year {Faker::Number.between(2019, 2020)}
  end
end