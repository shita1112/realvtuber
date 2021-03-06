# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  default_form_builder ApplicationFormBuilder

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  before_action :redirect_to_original_domain, if: %i[herokuapp_domain? production?]

  helper_method :notifications, :notifications_count, :notifications_exists?

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

  def not_authorized
    redirect_to root_path, alert: "権限がありません。"
  end

  def notifications
    @notifications ||= current_user.notifications.unread.preload(work: :trained_model).order(created_at: :desc)
  end

  def notifications_count
    @notifications_count ||= notifications.count
  end

  def notifications_exists?
    notifications_count > 0
  end
end
