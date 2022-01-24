# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password { 'f4k3p455w0rd' }
    name { 'name' }
    surname { 'surname' }
    # using dynamic attributes over static attributes in FactoryBot

    # if needed
    # is_active true
  end

  factory :post do
    association :user
    message { 'test message' }
    # using dynamic attributes over static attributes in FactoryBot

    # if needed
    # is_active true
  end

  factory :comment do
    association :user, :post
    body { 'test comment' }
  end
end
