class Favorite < ActiveRecord::Base

  # Associations
  belongs_to :term, counter_cache: true

end
