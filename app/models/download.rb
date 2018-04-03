class Download
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  belongs_to :subscriber
end
