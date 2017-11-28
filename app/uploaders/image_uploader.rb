class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave unless Rails.env.test?

  cloudinary_transformation transformation: [
    { width: 845, height: 597, crop: :limit }
  ] unless Rails.env.test?

  def extension_white_list
    %w(png jpg jpeg)
  end
end
