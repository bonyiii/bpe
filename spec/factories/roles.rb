# frozen_string_literal: true

FactoryGirl.define do
  factory :role do
    name { Faker::Internet.user_name }
  end
end
