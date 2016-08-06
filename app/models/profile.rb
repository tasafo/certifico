class Profile
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String, localize: true
  field :has_theme, type: Boolean, default: false

  validates_presence_of :name

  has_many :subscribers
end
