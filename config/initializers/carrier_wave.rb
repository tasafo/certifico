unless Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :file
    config.cache_storage = :file
    config.enable_processing = false
  end
end
