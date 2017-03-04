Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.action_mailer.default_url_options = { host: "localhost:3000" }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.slacked_disabled = false
  config.action_mailer.default charset: "utf-8"
  config.action_mailer.smtp_settings = {
    port:           '587',
    address:        'smtp.sendgrid.net',
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
    domain:         'heroku.com',
    authentication: :plain,
    enable_starttls_auto: true
  }
  ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.show_previews = true
  config.action_mailer.preview_path = "#{Rails.root}/spec/mailer/previews"
end
