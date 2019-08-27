# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "active_decorator"
gem "active_hash"
gem "asset_sync"
gem "awesome_print"
gem "bootsnap", ">= 1.4.2", require: false
gem "carrierwave"
gem "config"
gem "daemons"
gem "delayed_job_active_record"
gem "faraday"
gem "fog-aws"
gem "gon"
gem "google-analytics-rails"
gem "haml-rails"
gem "kaminari"
gem "mini_magick"
gem "meta-tags"
gem "mysql2", ">= 0.4.4"
gem "newrelic_rpm"
gem "pry-doc"
gem "pry-rails"
gem "puma", "~> 3.11"
gem "pundit"
gem "rails", "~> 6.0.0"
gem "sass-rails", "~> 5"
gem "sitemap_generator"
gem "tapp"
gem "webpacker", "~> 4.0"

group :development do
  gem "bullet"
  gem "letter_opener"
  gem "letter_opener_web"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "pry-alias"
  gem "pry-byebug"
  gem "rack-mini-profiler"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  # onkcopがrubocop最新版に対応していないので、一時的にforkを使う
  gem "onkcop", github: "shita1112/onkcop"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  gem "factory_bot_rails"
end

group :development, :test do
  gem "rspec-rails"
end

group :production do
  gem "rails_12factor"
end
