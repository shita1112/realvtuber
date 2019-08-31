# frozen_string_literal: true

class NotificationsController < ApplicationController
  def show
    notification = Notification.find(params[:id])
    authorize notification

    notification.update(read: true)
    redirect_to notification.work
  end
end
