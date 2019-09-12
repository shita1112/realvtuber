# frozen_string_literal: true

FactoryBot.define do
  factory :trained_model do
    name { "white_woman" }
    display_name { "白人女性" }
    face_image { Rack::Test::UploadedFile.new(support("face_image.png"), "image/jpeg") }
    trainer { "villain" }
  end
end
