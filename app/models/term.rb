class Term < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :favorites, dependent: :destroy

  # Scopes
  scope :next_queued, -> { order('runs asc, id asc').first }

  # Validations
  validates :term, presence: true

  # Methods
  def favorite
    Starrer.new(self).star
    self.runs += 1
    self.save!
  end

  def sample_tweets
    user.twitter.search(term, count: 30, result_type: "recent")
  end

  def conversion_percentage
    conversions.to_f / favorites_count.to_f
  end

end
