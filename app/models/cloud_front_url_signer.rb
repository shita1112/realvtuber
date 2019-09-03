# frozen_string_literal: true

class CloudFrontUrlSigner
  def initialize
    @signer = Aws::CloudFront::UrlSigner.new(
      key_pair_id: Rails.application.credentials.cloudfront_key_pair_id,
      private_key: Rails.application.credentials.cloudfront_private_key,
    )
  end

  def signed_url(url)
    return url unless Rails.env.production?

    @signer.signed_url(url, expires: Time.current + 1.week)
  end
end
