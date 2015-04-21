class User < ActiveRecord::Base

  has_many :user_bands
  has_many :bands, through: :user_bands
  has_many :events, through: :bands

  validates :password, 
          # you only need presence on create
          :presence => { :on => :create },
          # allow_nil for length (presence will handle it on create)
          :length   => { :minimum => 6, :allow_nil => true },
          # and use confirmation to ensure they always match
          :confirmation => true

  
  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password

  after_create :set_last_email_date

  def set_last_email_date
    self.last_email_date = Date.today
    self.save
  end


  def self.from_omniauth(auth, user)
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.photo = auth.info.image
      user.oauth_token = auth.credentials.token
      user.password = "dummy_password"
      user.password_confirmation = "dummy_password"
      user.save
      
  end

  def greeting
    greetings = ["Keep rockin, ", "sup, ", "yo, ", "Lookin good, ", "Greetings, ", "What's up, "]
    "#{greetings.sample}#{self.name}"
  end
end
