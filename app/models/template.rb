class Template
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Slug

  field :name, type: String
  field :font_color, type: String, default: '#000000'

  slug :name

  mount_uploader :image, ImageUploader

  validates_presence_of :name, :font_color
  validates_length_of :name, maximum: 100
  validates_length_of :font_color, maximum: 7

  belongs_to :user
  has_many :certificates, dependent: :restrict_with_error
end
