# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    filename { "filename.mp4" }
    original_video { video }
    df_video { video }
    comparison_video { video }
    original_image { image }
    df_image { image }
    comparison_image { image }
  end
end
