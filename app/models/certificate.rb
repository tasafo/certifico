class Certificate
  VALID_SITE_REGEX = %r{(^$)|(^(http|https)://[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?/.*)?$)}

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

  validates_presence_of :template_id, :category_id, :title, :initial_date,
                        :final_date, :workload, :local
  validates_length_of :title, maximum: 200
  validates_format_of :site, with: VALID_SITE_REGEX

  belongs_to :user
  belongs_to :template
  belongs_to :category
  has_many :subscribers, dependent: :restrict_with_error
  has_many :downloads

  scope :with_relations, -> { includes(:user, :template, :category) }

  def destroy_image
    image_file = image.file

    ImageFile.remove(image_file) if image_file

    image_cached = Rails.root.join('tmp', 'certificates', id.to_s)

    File.delete(image_cached) if File.exist?(image_cached)
  end

  def template_image
    CertificateTemplateImage.new(self).pull
  end

  def queue_emails(subscriber_id, params)
    if subscriber_id
      subscriber_ = Subscriber.find(subscriber_id)

      subscriber_&.send_certificate_by_email
    else
      subscribers_ = Subscriber.search(params, self)[:records]

      subscribers_.each(&:send_certificate_by_email)
    end
  end
end
