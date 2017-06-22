require 'rollbar'

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN']
end

# Rollbar.error('Hi Steve')
