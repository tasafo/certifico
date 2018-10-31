source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails', '5.1.6'
gem 'rails-i18n'

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-colorpicker-rails'

gem 'kaminari'
gem 'kaminari-mongoid'

gem 'jbuilder', '~> 2.0'

gem 'mongoid', '~> 6.1'
gem 'mongoid-slug'

gem 'devise'
gem 'devise-i18n'
gem 'simple_form'

gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'carrierwave-i18n'

gem 'prawn'
gem 'prawn-table'

gem 'roo'
gem 'roo-xls'

gem 'sidekiq'
gem 'sinatra', require: false

gem 'airbrake', '~> 6.1'

gem 'puma'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'pry-rails'
end

group :test do
  gem 'simplecov', '0.16.1', require: false
  gem 'capybara'
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'selenium-webdriver'
  gem 'codeclimate-test-reporter'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :production do
  gem 'cloudinary'
  gem 'newrelic_rpm'
end
