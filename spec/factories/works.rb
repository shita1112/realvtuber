# frozen_string_literal: true

FactoryBot.define do
  factory :work do
    sequence(:filename) {|n| "filename_#{n}.mp4" }
    original_video { video }
    df_video { video }
    comparison_video { video }
    original_image { image }
    df_image { image }
    comparison_image { image }
    trained_model
    user
  end
end
