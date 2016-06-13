class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :theme, type: String

  belongs_to :user
  belongs_to :profile
  belongs_to :certificate

  accepts_nested_attributes_for :user

  validates_presence_of :certificate_id, :profile_id
end
