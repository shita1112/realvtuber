# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    role { "normal" }
    confirmed_at { Time.current }

    trait :admin do
      role { "admin" }
    end
  end
end
