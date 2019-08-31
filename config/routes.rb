# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root "works#index", as: :user_root
  end
  root "home#index"

  resources :works, only: %i[index show new create destroy] do
    resource :df_video, only: :show, module: "works"
    resource :comparison_video, only: :show, module: "works"
  end
  resources :notifications, only: :show

  devise_for :users
  get "sitemap", to: redirect("#{Rails.application.credentials.s3_cdn_url}/sitemaps/sitemap.xml.gz")
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
