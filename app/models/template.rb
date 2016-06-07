class Template
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  mount_uploader :image, ImageUploader

  validates_presence_of :name

  belongs_to :user
  has_many :certificates
end
