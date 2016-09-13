class History
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :notification, type: String
  field :status,       type: String, default: '1'

  embedded_in :credit
end
