CarrierWave.configure do |config|
  if Rails.env.production? || (Rails.env.development? && ENV['CLOUDINARY_URL'])
    config.cache_storage = :file
  else
    config.storage = :file
    config.enable_processing = false
  end
end
