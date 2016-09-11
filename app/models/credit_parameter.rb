class CreditParameter
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :price,   type: Float

  validates_presence_of :price
  validates :price, numericality: { greater_than_or_equal_to: 0.1 }
end
