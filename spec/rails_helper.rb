# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start 'rails'

if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/cuprite'
require 'database_cleaner-mongoid'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.order = :random

  config.include SpecHelpers

  config.include FactoryBot::Syntax::Methods

  config.include Capybara::DSL

  config.include Devise::Test::ControllerHelpers, type: :controller

  options = {
    headless: (ENV['BROWSER'] ? false : true),
    pending_connection_errors: false,
    timeout: 30,
    process_timeout: 30,
    url_whitelist: %w[127.0.0.1]
  }

  Capybara.register_driver :cuprite do |app|
    Capybara::Cuprite::Driver.new(app, options)
  end

  Capybara.server = :puma, { Silent: true }

  Capybara.javascript_driver = :cuprite

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].clean
  end

  config.after(:suite) do
    FileUtils.rm_rf(Rails.root.join('public', 'tmp'))
  end

  Mongoid.logger.level = Logger::INFO

  I18n.locale = 'pt-BR'
end
