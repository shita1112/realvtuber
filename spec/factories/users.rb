# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "a1125ts@gmail.com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    role { "normal" }
    confirmed_at { Time.current }
  end
end
