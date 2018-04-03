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
  validates_uniqueness_of :user, scope: [:profile, :certificate, :theme]
  validates_length_of :theme, maximum: 100

  scope :with_relations, -> { includes(:user, :profile, :certificate, :downloads) }

  before_save do
    self.theme = nil unless self.profile.has_theme?
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def self.search(params, certificate)
    conditions = { certificate: certificate }

    conditions[:profile] = Profile.find_by(name: params[:profile]) unless params[:profile].blank?

    unless params[:search].blank?
      user_ids = User.where(email: /#{params[:search]}/).pluck(:id)

      user_ids += User.where(full_name: /#{params[:search]}/i).pluck(:id)

      conditions['user_id'] = { "$in" => user_ids }
    end

    records = Subscriber.with_relations.where(conditions).sort_by { |subscriber| subscriber.user.full_name }

    { records: records, count: records.size }
  end

  def self.import(certificate, profile_id, sheet)
    result = true

    profile = Profile.find(profile_id)

    sheet.each do |line|
      email, name = line[0], line[1]

      unless email.match(VALID_EMAIL_REGEX)
        result = I18n.t('notice.invalid_email', email: email)
        break
      end

      user_name = email.split('@')[0].gsub('.', '')

      user = User.find_by(email: email)

      user = User.create(
        email: email,
        full_name: name,
        user_name: user_name,
        password: rand(11111111..99999999)
      ) unless user

      fields = { user: user, certificate: certificate, profile: profile }

      fields[:theme] = line[2] if profile.has_theme and !line[2].blank?

      Subscriber.find_or_create_by(fields)
    end

    result
  end
end
