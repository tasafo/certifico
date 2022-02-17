source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby RUBY_VERSION

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails', '~> 6.1'
gem 'rails-i18n', '~> 6.0'

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.4.1'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-colorpicker-rails'

gem 'pagy'

gem 'jbuilder', '~> 2.0'

gem 'mongoid', '7.3.3'
gem 'mongoid-slug'

gem 'devise'
gem 'devise-i18n'
gem 'simple_form'

gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'carrierwave-i18n'
gem 'cloudinary', '1.22.0'

gem 'prawn'
gem 'prawn-table'

gem 'roo'
gem 'roo-xls'

gem 'sidekiq'
gem 'sinatra', require: false

gem 'puma'

gem 'bootsnap'

gem 'webpacker'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner-mongoid', '2.0.1'
  gem 'faker'
end

group :test do
  gem 'simplecov', '0.21.2', require: false
  gem 'simplecov-cobertura', require: false
  gem 'capybara', '3.36.0'
  gem 'cuprite', '0.13'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end
