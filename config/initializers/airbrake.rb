Airbrake.configure do |c|
  c.project_key = ENV['AIRBRAKE_API_KEY']
  c.project_id = ENV['AIRBRAKE_PROJECT_ID']

  c.root_directory = Rails.root

  c.logger = Rails.logger

  c.environment = Rails.env

  c.ignore_environments = %w(development test)

  c.blacklist_keys = [/password/i, /authorization/i]
end
