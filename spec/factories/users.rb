# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "a1125ts@gmail.com" }
    password { "testtest" }
    # encrypted_password { "$2a$11$QcfxcxJOY7i0jGpiw3EzD./v7QgbdPROVnx4MUTQENKsaSc6UfpzK" } # a
    role { "normal" }
  end
end
