# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root "works#index", as: :authenticated_root
  end
  root "home#index"

  get "disclaimer", to: "home#disclaimer", as: "disclaimer"
  get "policy", to: "home#policy", as: "policy"
  get "contact", to: "home#contact", as: "contact"

  resources :works, only: %i[index show new create destroy]
  resources :notifications, only: :show
  resource :notifications, only: :update # `PATCH /notifications`でBulk Update
  resource :order, only: :show

  namespace :admin do
    resource :dashboard, only: :show
  end

  devise_for :users
  get "sitemap", to: redirect("#{Rails.application.credentials.s3_cdn_url}/sitemaps/sitemap.xml.gz")
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
