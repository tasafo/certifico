class Certificate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :initial_date, type: Date
  field :final_date, type: Date
  field :workload, type: Integer
  field :local, type: String
  field :site, type: String

  mount_uploader :image, ImageUploader

  validates_presence_of :title, :initial_date, :final_date, :workload, :local

  belongs_to :user
  belongs_to :template
  belongs_to :category
end
