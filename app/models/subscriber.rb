class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :theme, type: String

  belongs_to :user
  belongs_to :profile
  belongs_to :certificate
  has_many   :downloads, dependent: :destroy

  accepts_nested_attributes_for :user

  validates_presence_of :certificate_id, :profile_id
  validates_uniqueness_of :user, scope: %i[profile certificate theme]
  validates_length_of :theme, maximum: 100

  scope :with_relations, -> do
    includes(:user, :profile, :certificate, :downloads)
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save do
    self.theme = nil unless profile.has_theme?
  end

  before_create do
    user_found = User.find_by(email: user.email)

    if user_found
      self.user = user_found
    else
      user.password = rand(111_111_11..999_999_99)
    end
  end

  def send_certificate_by_email
    CertificateMailer.with(subscriber_id: id.to_s).with_attachment.deliver_later
  end

  def generate_certificate
    CertificateGenerator.new(self)
  end

  def certificate_file_name
    user_name = user.full_name.parameterize
    certificate_title = certificate.title.parameterize
    profile_name = profile.name.parameterize

    "certifico_#{user_name}_#{certificate_title}_#{profile_name}.pdf"
  end

  def create_certificate(pdf_file)
    directory = Rails.root.join('tmp', 'certificates').to_path
    Dir.mkdir(directory) unless File.exist?(directory)

    generate_certificate.render(pdf_file)

    downloads.create
  end

  def self.search(params, certificate)
    filter = conditions(certificate, params[:profile], params[:search])

    records = Subscriber.with_relations.where(filter)
                        .sort_by { |subscriber| subscriber.user.full_name }

    { records: records, count: records.size }
  end

  def self.conditions(certificate, profile, search)
    conditions = { certificate: certificate }

    conditions[:profile] = Profile.find_by(name: profile) unless profile.blank?

    conditions['user_id'] = user_ids(search) unless search.blank?

    conditions
  end

  def self.user_ids(search)
    regex = Regexp.new(Regexp.escape(search), Regexp::IGNORECASE)

    user_ids = User.where(email: regex).pluck(:id)

    user_ids += User.where(full_name: regex).pluck(:id)

    { '$in' => user_ids }
  end

  def self.import(certificate, profile_id, sheet)
    profile = Profile.find(profile_id)

    import_subscriber(sheet, certificate, profile)
  end

  def self.raise_invalid_email(email)
    notice = I18n.t('notice.invalid_email', email: email)

    raise notice unless email.match?(VALID_EMAIL_REGEX)
  end

  def self.import_subscriber(sheet, certificate, profile)
    sheet.each do |line|
      email = line[0]

      raise_invalid_email(email)

      user = find_user(email: email, name: line[1], user_name: email.split('@').first.delete('.'))

      args = { user: user, certificate: certificate, profile: profile, theme: line[2] }

      Subscriber.find_or_create_by(select_fields(**args))
    end
  end

  def self.select_fields(**args)
    profile = args[:profile]
    theme = args[:theme]

    fields = { user: args[:user], certificate: args[:certificate],
               profile: profile }

    fields[:theme] = theme if profile.has_theme && !theme.blank?

    fields
  end

  def self.find_user(email:, name:, user_name:)
    user = User.find_by(email: email)

    user ||= User.create(email: email, full_name: name, user_name: user_name,
                         password: rand(11_111_111..99_999_999))

    user
  end
end
