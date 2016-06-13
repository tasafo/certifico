class Profile
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String, localize: true

  validates_presence_of :name

  has_many :subscribers
end
