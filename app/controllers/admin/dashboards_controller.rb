# frozen_string_literal: true

class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize :dashboard, :show?

    @jobs = Delayed::Job.created_within_24h.order(created_at: :desc)
    @works = Work.created_within_24h.order(created_at: :desc)
    @users = User.created_within_24h.order(created_at: :desc)
  end
end
