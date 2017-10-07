source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails', '~> 5.0'
gem 'rails-i18n'

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-colorpicker-rails'

gem 'turbolinks', '~> 5.x'

gem 'jbuilder', '~> 2.0'

gem 'mongoid', '~> 6.1'
gem 'mongoid-slug'

gem 'devise'
gem 'devise-i18n'
gem 'simple_form'

gem 'cloudinary'
gem 'carrierwave'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'

gem 'prawn'
gem 'prawn-table'

gem 'roo'
gem 'roo-xls'

gem 'pagseguro-oficial'

#gem 'sidekiq'
#gem 'sinatra', require: false
#gem 'slim'

gem 'airbrake', '~> 6.1'

gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'pry-rails'
end

group :test do
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
end

group :development do
  gem 'thin'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'unicorn'
#  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
