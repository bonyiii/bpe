FactoryGirl.define do
  factory :role do
    name { Faker::Internet.user_name }

  end
end
