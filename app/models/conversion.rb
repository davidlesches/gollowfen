class Conversion < ActiveRecord::Base

  # Associations
  belongs_to :term, counter_cache: true

end
