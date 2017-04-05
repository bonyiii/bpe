# frozen_string_literal: true

FactoryGirl.define do
  factory :base_user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "user_#{n}@test.hu" }

    transient { default_roles [] }

    after(:build) do |user, evaluator|
      user.password_confirmation = user.password = 'password'
      [evaluator.default_roles].flatten.map do |role_name|
        user.roles << FactoryGirl.create(:role, name: role_name)
      end
    end

    factory :user do
      default_roles [:guest]
    end

    factory :admin do
      default_roles [:admin]
    end
  end
end
