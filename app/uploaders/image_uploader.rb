class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  if CloudinaryReady.up?
    include Cloudinary::CarrierWave

    cloudinary_transformation transformation: [
      { width: 845, height: 597, crop: :limit }
    ]
  end

  def extension_allowlist
    %w[png jpg jpeg]
  end

  def store_dir
    folder = Rails.env.test? ? 'tmp' : 'uploads'

    Rails.root.join('public', folder, model.class.name.pluralize.downcase, model.id)
  end
end
