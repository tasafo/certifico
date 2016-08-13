class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Slug

  field :theme, type: String

  belongs_to :user
  belongs_to :profile
  belongs_to :certificate

  accepts_nested_attributes_for :user

  validates_presence_of :certificate_id, :profile_id

  slug do |cur_object|
    cur_object.certificate.title.to_url
  end
end
