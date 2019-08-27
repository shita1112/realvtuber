# frozen_string_literal: true

SitemapGenerator::Sitemap.default_host = "https://realvtuber.shita1112.com"
SitemapGenerator::Sitemap.sitemaps_host = "#{Rails.application.credentials.s3_url}/#{Rails.application.credentials.s3_bucket_name}"
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
  fog_provider: "AWS",
  fog_directory: Rails.application.credentials.s3_bucket_name,
  fog_region: Rails.application.credentials.fog_region,
  aws_access_key_id: Rails.application.credentials.aws_access_key_id,
  aws_secret_access_key: Rails.application.credentials.aws_secret_access_key,
)

SitemapGenerator::Sitemap.create do
end
