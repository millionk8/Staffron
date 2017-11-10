FactoryGirl.define do
  factory :category do
    type 'BillingCategory'
    sequence(:name) { |n| "Category #{n}" }
    status 0
    company
    app
  end
end
