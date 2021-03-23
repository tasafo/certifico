class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave unless ENV['CLOUDINARY_URL'].nil?

  cloudinary_transformation transformation: [
    { width: 845, height: 597, crop: :limit }
  ] unless ENV['CLOUDINARY_URL'].nil?

  def extension_allowlist
    %w[png jpg jpeg]
  end

  def store_dir
    "uploads/#{model.class.name.pluralize.downcase}/#{model.id}"
  end
end
