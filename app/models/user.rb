class User < ActiveRecord::Base

  # Gems
  has_secure_password

  # Associations
  has_many :terms, dependent: :destroy
  has_many :favorites, through: :terms
  has_many :followers, dependent: :destroy

  # Validations
  validates :name, :email, presence: true
  validates :email, email: true

  # Methods
  def add_oauth(auth)
    self.oauth_token  = auth['credentials']['token']
    self.oauth_secret = auth['credentials']['secret']
    self.screen_name  = auth['info']['nickname']
    self.save!
  end

  def twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = CONFIG[:twitter_key]
      config.consumer_secret     = CONFIG[:twitter_secret]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end

  def import_followers
    FollowerImporter.new(self).import
  end

end
