class CertificateImageUploader < ImageUploader
  WIDTH = 300
  HEIGHT = 150

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
