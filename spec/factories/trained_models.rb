# frozen_string_literal: true

FactoryBot.define do
  factory :trained_model do
    sequence(:name) {|n| "name_#{n}" }
    sequence(:display_name) {|n| "display_name_#{n}" }
    face_image { File.open(support("face_image.png")) }
    trainer { TrainedModel.trainers.keys.sample }
  end
end
