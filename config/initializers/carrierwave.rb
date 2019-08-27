# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"

  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: Rails.application.credentials.aws_access_key_id,
    aws_secret_access_key: Rails.application.credentials.aws_secret_access_key,
    region: Rails.application.credentials.fog_region,
  }

  config.fog_directory = Rails.application.credentials.fog_directory

  config.fog_public = true

  if Rails.env.production?
    config.storage = :fog
    config.asset_host = Rails.application.credentials.cdn_url
  else
    config.storage = :file
  end

  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
