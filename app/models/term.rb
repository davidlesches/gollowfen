class Term < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :conversions, dependent: :destroy

  # Validations
  validates :term, presence: true

  # Methods
  def favorite
    Starrer.new(self).star
    self.runs += 1
    self.touch(:last_run)
    self.save!
  rescue
  end

  def sample_tweets
    user.twitter.search(term, count: 30, result_type: "recent")
  end

  def conversion_percentage
    (conversions_count.to_f / favorites_count.to_f) * 100
  end

end
