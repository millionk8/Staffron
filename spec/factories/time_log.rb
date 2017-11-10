FactoryGirl.define do
  factory :time_log do
    user
    category
    started_at Time.current - 10.minutes
    stopped_at Time.current
    note ''
    deleted false
  end
end