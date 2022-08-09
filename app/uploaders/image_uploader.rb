class ImageUploader < CarrierWave::Uploader::Base
  def extension_allowlist
    %w[png jpg jpeg]
  end

  def content_type_allowlist
    [/image\//]
  end

  def store_dir
    folder = Rails.env.test? ? 'tmp' : 'uploads'

    Rails.root.join('public', folder, model.class.name.pluralize.downcase, model.id)
  end
end
