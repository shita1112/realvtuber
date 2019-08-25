# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cats
  root to: "cats#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
