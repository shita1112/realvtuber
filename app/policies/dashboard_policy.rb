# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def show?
    user.admin?
  end
end
