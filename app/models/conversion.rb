class Conversion < ActiveRecord::Base

  # Associations
  belongs_to :term, counter_cache: true

  # Scopes
  scope :last_week, -> { where('created_at >= ?', (Time.zone.now - 1.week).beginning_of_week)
                         .order('created_at asc') }

end
