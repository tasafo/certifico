class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave if Rails.env.production?

  cloudinary_transformation transformation: [
    { width: 845, height: 597, crop: :limit }
  ] if Rails.env.production?

  def extension_white_list
    %w(png jpg jpeg)
  end
end
