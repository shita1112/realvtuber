# frozen_string_literal: true

# 参照: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
# worksers 2にするとメモリ500M制限超えちゃうので注意
workers 1
threads_count = 5
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV["PORT"]
environment "production"

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
