CarrierWave.configure do |config|
  if Rails.env.production?
    config.cache_storage = :file
  else
    config.storage = :file
    config.enable_processing = false
  end
end
