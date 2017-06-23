require 'rollbar'

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN']
  unless Rails.env.production?
    config.enabled = false
  end
end
