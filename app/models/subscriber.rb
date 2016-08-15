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

  def self.import(certificate_id, profile_id, sheet)
    certificate = Certificate.find(certificate_id)
    profile = Profile.find(profile_id)

    sheet.each do |line|
      email = line[0]
      name = line[1]

      user = User.find_by(email: email) || User.create(email: email, name: name, password: rand(11111111..99999999))

      subscriber = Subscriber.find_by(user_id: user, certificate_id: certificate, profile_id: profile)

      unless subscriber
        subscriber = user.subscribers.create(certificate: certificate, profile: profile)

        if profile.has_theme
          subscriber.theme = line[2].to_s
          subscriber.save
        end
      end
    end
  end
end
