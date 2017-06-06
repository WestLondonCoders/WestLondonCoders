source 'https://rubygems.org'
ruby '2.3.3'

# Rails, and deps of Rails that we have locked at specific versions

gem 'rails',        '4.2.7.1'
gem 'jquery-rails', '>= 4.0.4'
gem 'sassc-rails'
gem 'sprockets',    '~> 3.6.0'
gem 'uglifier',     '>= 1.0.3'

# Gems we have added beyond those installed by Rails

gem 'pg'
gem 'rails_12factor', group: :production
gem 'haml'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.1.0'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'unicorn'
gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem "recaptcha", require: "recaptcha/rails"
gem 'cancancan', '~> 1.15.0'
gem 'dotenv', '~> 1.0.2'
gem 'dotenv-rails', '~> 1.0.2', require: false
gem 'friendly_id'
gem 'jquery-turbolinks'
gem 'cocoon'
gem "autoprefixer-rails"
gem 'ransack', git: "https://github.com/activerecord-hackery/ransack.git"
gem 'thin'
gem 'slacked'
gem 'carrierwave', '~> 1.0'
gem 'fog'
gem "mini_magick"
gem 'file_validators'
gem 'sendgrid-ruby'
gem 'premailer-rails'
gem 'nokogiri'
gem "rolify"
gem 'modernizr-rails'
gem 'jquery-minicolors-rails'
gem 'chosen-rails'
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'jquery-atwho-rails'

group :development, :test do
  gem 'byebug'
  gem 'pry'
  gem 'rspec-rails'
  gem 'capybara'
  gem "factory_girl_rails", "~> 4.0"
  gem 'scss_lint'
  gem 'railroady'
  gem 'launchy'
  gem 'jasmine-rails', '~> 0.12.0'
  gem 'jasmine-core', '~> 2.3.4'
  gem 'rubocop', '~> 0.47.1', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'poltergeist', '~> 1.11.0'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring', '2.0.1'
  gem 'spring-commands-rspec'
end
