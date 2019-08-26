# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "index#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
