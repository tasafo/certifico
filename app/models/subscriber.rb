class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :theme, type: String

  belongs_to :user
  belongs_to :profile
  belongs_to :certificate

  accepts_nested_attributes_for :user

  validates_presence_of :certificate_id, :profile_id
  validates_uniqueness_of :user, scope: [:profile, :certificate]
  validates_length_of :theme, maximum: 100

  before_save do
    self.theme = nil unless self.profile.has_theme?
  end

  after_create do
    self.certificate.user.update(current_credits: self.certificate.user.current_credits-1)
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def self.import(certificate, profile_id, sheet)
    result = true
    profile = Profile.find(profile_id)

    sheet.each do |line|
      email, name = line[0], line[1]

      break if certificate.user.current_credits <= 0

      unless email.match(VALID_EMAIL_REGEX)
        result = I18n.t('notice.invalid_email', email: email)
        break
      end

      user_name = email.split('@')[0].gsub('.','')

      user = User.find_by(email: email) || User.create(email: email, full_name: name, user_name: user_name, password: rand(11111111..99999999))

      subscriber = Subscriber.find_by(user_id: user.id, certificate_id: certificate.id, profile_id: profile.id)

      unless subscriber
        subscriber = Subscriber.create(user: user, certificate: certificate, profile: profile)

        subscriber.update(theme: line[2].to_s) if profile.has_theme
      end
    end

    result
  end
end
