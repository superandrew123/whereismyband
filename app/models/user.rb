class User < ActiveRecord::Base

  has_many :user_bands
  has_many :bands, through: :user_bands
  has_many :events, through: :bands

  validates_confirmation_of :password
  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email, :password

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password


  def self.from_omniauth(auth, user)
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.password = "dummy_password"
      user.save!
      user
  end

end
