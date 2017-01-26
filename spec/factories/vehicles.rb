FactoryGirl.define do
  factory :vehicle do
    sequence(:name) { |n| "#{Faker::Vehicle.manufacture}_#{n}" }
  end
end
