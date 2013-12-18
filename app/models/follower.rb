class Follower < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Validations
  validates :screen_name, presence: true

end
