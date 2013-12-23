class Favorite < ActiveRecord::Base

  # Associations
  belongs_to :term, counter_cache: true

  # Scopes
  scope :last_week, -> { where('favorited_at >= ?', (Time.zone.now - 1.week).beginning_of_week)
                         .order('favorited_at asc') }

end
