# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :redirect_to_original_domain, if: %i[herokuapp_domain? production?]

  private

  def redirect_to_original_domain
    redirect_to "https://#{Settings.original_domain}#{request.fullpath}", status: 301
  end

  def herokuapp_domain?
    request.domain == Settings.herokuapp_domain
  end

  def production?
    Rails.env.production?
  end
end
