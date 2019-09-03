# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    notification = Notification.find(params[:id])
    authorize notification

    notification.update(read: true)
    redirect_to notification.work
  end

  # `PATCH /notifications`でBulk Update
  # TODO: `PATCH /notifications/:id`と紛らわしいので、`PATCH /notification_collection`とかにしたほうがいいかも
  def update
    current_user.notifications.update_all(read: true)
    redirect_back fallback_location: root_path, notice: "全ての通知を既読にしました。"
  end
end
