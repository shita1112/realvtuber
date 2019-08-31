# frozen_string_literal: true

class WorkPolicy < ApplicationPolicy
  def show?
    admin_or_has_record?
  end

  def destroy?
    admin_or_has_record?
  end
end
