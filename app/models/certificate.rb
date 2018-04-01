class Certificate
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Slug

  field :title, type: String
  field :initial_date, type: Date
  field :final_date, type: Date
  field :workload, type: String
  field :local, type: String
  field :site, type: String

  slug :title

  mount_uploader :image, ImageUploader

  validates_presence_of :title, :initial_date, :final_date, :workload, :local
  validates_length_of :title, maximum: 100
  validates_format_of :site,
    with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/

  belongs_to :user
  belongs_to :template
  belongs_to :category
  has_many :subscribers, dependent: :restrict
  has_many :downloads

  scope :with_relations, -> { includes(:user, :template, :category) }
end
