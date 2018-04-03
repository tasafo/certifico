class Category
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String, localize: true
  field :preposition, type: String, localize: true

  validates_presence_of :name, :preposition

  has_many :certificates, dependent: :restrict
end
