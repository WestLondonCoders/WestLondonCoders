source 'https://rubygems.org'
ruby '2.4.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',        '5.1.4'
gem 'pg', '0.21.0'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'nokogiri'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem "recaptcha", require: "recaptcha/rails"
gem 'cancancan'
gem 'friendly_id'
gem 'jquery-turbolinks'
gem 'cocoon'
gem "autoprefixer-rails"
gem 'ransack', git: "https://github.com/activerecord-hackery/ransack.git"
gem 'slacked'
gem 'carrierwave'
gem 'fog'
gem "mini_magick"
gem 'file_validators'
gem 'sendgrid-ruby'
gem 'premailer-rails'
gem "rolify"
gem 'modernizr-rails'
gem 'jquery-minicolors-rails'
gem 'chosen-rails'
gem 'trix'
gem 'rollbar'
gem 'sitemap_generator'
gem 'gon'
gem 'chart-js-rails'
gem 'grape'
gem 'grape-entity'
gem 'rest-client'

group :development, :test do
  gem 'rails-controller-testing'
  gem 'pry'
  gem 'rspec-rails', '~> 3.6'
  gem 'capybara'
  gem 'poltergeist'
  gem "factory_bot_rails"
  gem 'scss_lint', require: false
  gem 'railroady'
  gem 'launchy'
  gem 'rubocop', '~> 0.47.1', require: false
  gem 'dotenv-rails', require: 'dotenv/rails-now'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 2.8.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
