class TemplateImageUploader < ImageUploader
  WIDTH = 845
  HEIGHT = 597

  if CloudinaryReady.up?
    include Cloudinary::CarrierWave

    cloudinary_transformation transformation: [
      { width: WIDTH, height: HEIGHT, crop: :limit }
    ]
  else
    include CarrierWave::MiniMagick

    process resize_to_fit: [WIDTH, HEIGHT]
  end
end
