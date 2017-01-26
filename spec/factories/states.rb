FactoryGirl.define do
  factory :state do
    sequence(:name) { |n| "state_#{n}" }
  end
end
