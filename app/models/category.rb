class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String, localize: true
  field :preposition, type: String, localize: true

  validates_presence_of :name, :preposition
end
