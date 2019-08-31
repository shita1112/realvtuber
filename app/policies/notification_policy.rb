# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def show?
    admin_or_has_record?
  end
end
