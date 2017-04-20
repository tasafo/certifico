class Download
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  belongs_to :user
  belongs_to :certificate
  belongs_to :subscriber
end
