class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Slug

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  field :full_name,          type: String, default: ""
  field :user_name,          type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :name_changed,      type: Boolean, default: false
  field :admin,             type: Boolean, default: false

  slug :user_name

  has_many :templates
  has_many :certificates
  has_many :subscribers
  has_many :downloads

  validates_presence_of :email, :full_name, :user_name
  validates_length_of :email, maximum: 100
  validates_length_of :full_name, maximum: 100
  validates_length_of :user_name, maximum: 50

  index({ email: 1 }, { background: true })
  index({ user_name: 1 }, { background: true })
end
