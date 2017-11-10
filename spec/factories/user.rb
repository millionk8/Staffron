FactoryGirl.define do
  factory :user do
    company
    sequence(:email) {|n| "person#{n}@example.com"}
    password '123456789'
  end
end
