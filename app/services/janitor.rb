class Janitor

  def self.clean
    new()
  end

  def initialize
    cleanup
  end

  def cleanup
    favorites_to_unfavorite.find_each do |fav|
      #fav.term.user.twitter.unfavorite(fav.tweet_id.to_i)
      #fav.term.user.twitter.unfavorite(fav.tweet_id)
      #fav.unfavorited = true
      #fav.save!
      unfavorite fav
    end
  end

  def favorites_to_unfavorite
    Favorite.where("unfavorited = ? AND favorited_at > ?", false, Time.zone.now - 60.days)
  end

  def unfavorite fav
    puts fav.permalink
    user = fav.term.user
    thwak user, fav, 1
    thwak user, fav, 2
    thwak user, fav, 3
    fav.unfavorited = true
    fav.save!
  end

  def thwak user, fav, number
    begin
      puts "thwak #{number}"
      user.twitter.unfavorite(fav.tweet_id.to_i)
    rescue Exception => e
      # do nothing
      puts e.message
    end
    sleep 1
  end

end

# Favorite.where("unfavorited = ? AND favorited_at < ?", false, Time.zone.now - 3.days).find_each { |a| unfavorite a }

