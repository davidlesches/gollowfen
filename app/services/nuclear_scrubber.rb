class NuclearScrubber

  attr_reader :user

  def initialize user
    @user = user
    scrub
  end

  def scrub
    favs = favorites_to_unfavorite
    tweet_ids = favs.map { |a| a.tweet_id.to_i }
    favorite_ids = favs.map { |a| a.id.to_i }

    user.unfavorite(tweet_ids)
    Favorite.find(favorite_ids).update_all(unfavorited: true)
  end

  def favorites_to_unfavorite
    user.favorites.where('unfavorited = ?', false).select('id, tweet_id').order('favorites.id asc').limit(100)
  end

end

