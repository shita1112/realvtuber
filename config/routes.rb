# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "index#index"

  devise_for :users
  get "sitemap", to: redirect("#{Rails.application.credentials.s3_cdn_url}/sitemaps/sitemap.xml.gz")
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
