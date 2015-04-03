class Band < ActiveRecord::Base
  has_many :user_bands
  has_many :users, through: :user_bands
  has_many :events

end
