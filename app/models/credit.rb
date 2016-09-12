class Credit
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :quantity,    type: Integer
  field :price,       type: Float
  field :paid_at,     type: DateTime
  field :gateway,     type: String, default: 'pagseguro'
  field :transaction, type: String
  field :method,      type: String
  field :status,      type: String, default: '1'

  validates_presence_of :quantity, :price, :gateway, :status
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  embeds_many :histories

  before_update do
    if self.paid_at_changed? && self.paid_at_was.nil?
      self.user.current_credits += self.quantity
    end
  end
end
