FactoryGirl.define do
  factory :company do
    status 0
    sequence(:name) {|n| "Company #{n}"}
    address Faker::Address.secondary_address
    address2 Faker::Address.secondary_address
    city Faker::Address.city
    state Faker::Address.state
    zip Faker::Address.zip
    country Faker::Address.country
  end
end
