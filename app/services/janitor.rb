class Janitor

  def self.clean
    new()
  end

  def initialize
    cleanup
  end

  def cleanup
    favorites_to_unfavorite.each do |fav|
      fav.term.user.twitter.unfavorite(fav.tweet_id)
      fav.unfavorited = true
      fav.save!
    end
  end

  def favorites_to_unfavorite
    Favorite.where("unfavorited = ? AND favorited_at < ?", false, Time.zone.now - 3.days)
  end

end