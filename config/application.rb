# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Realvtuber
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = "Tokyo"

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.skip_routes true
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false,
                       system_specs: true,
                       model_specs: true,
                       fixtures: true
      g.fixture_replacement :factory_bot,
                            dir: "spec/factories"
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :options]
      end
    end

    # バリデーションエラー時に、自動でHTML変更
    # MDB4用にカスタマイズ
    config.action_view.field_error_proc = ->(html_tag, instance) do
      if instance.is_a?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        a = html_tag.split('class="')
        new_html_tag = if a.present?
                         a[0] + 'class="is-invalid ' + a[1]
                       else
                         html_tag[0..-3] + 'class="is_invalid" />'
                       end
        # "#{new_html_tag}<div class='invalid-feedback'>#{instance.error_message.first}</div>".html_safe
        new_html_tag.html_safe
      end
    end

    config.autoload_paths << Rails.root.join("lib", "constraints")

    config.active_job.queue_adapter = :delayed_job
  end
end
