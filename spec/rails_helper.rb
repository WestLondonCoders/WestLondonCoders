ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :poltergeist
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    Capybara.use_default_driver
  end

  config.before(:each, multithreaded: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
    Capybara.current_driver = :poltergeist_billy
    PuffingBillyStubs.stub_mathjax!(proxy)
  end

  config.before(:each, js_with_silent_errors: true) do
    Capybara.register_driver :poltergeist_with_silent_errors do |app|
      billy_config = [
        '--ignore-ssl-errors=yes',
        "--proxy=#{Billy.proxy.host}:#{Billy.proxy.port}"
      ]

      Capybara::Poltergeist::Driver.new(
        app,
        phantomjs_options: billy_config,
        phantomjs_logger: StringIO.new,
        js_errors: false
      )
    end

    DatabaseCleaner.strategy = :truncation
    Capybara.current_driver = :poltergeist_with_silent_errors
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    ActionMailer::Base.deliveries.clear
  end
end
