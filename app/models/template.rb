class Template
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Slug

  field :name, type: String
  field :font_color, type: String, default: '#000000'

  slug :name

  mount_uploader :image, TemplateImageUploader

  validates_presence_of :name, :font_color
  validates_length_of :name, maximum: 100
  validates_length_of :font_color, maximum: 7

  belongs_to :user
  has_many :certificates, dependent: :restrict_with_error

  def destroy_image
    image_file = image.file

    ImageFile.remove(image_file) if image_file

    image_cached = Rails.root.join('tmp', 'templates', id.to_s)

    File.delete(image_cached) if File.exist?(image_cached)
  end
end
