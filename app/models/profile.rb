class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String, localize: true

  validates_presence_of :name
end
