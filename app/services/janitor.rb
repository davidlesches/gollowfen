class Janitor

  def self.clean
    new()
  end

  def initialize
    cleanup
  end

  def cleanup
    favorites_to_unfavorite.find_each do |fav|
      #fav.term.user.twitter.unfavorite(fav.tweet_id)
      #fav.unfavorited = true
      #fav.save!
      unfavorite fav
    end
  end

  def favorites_to_unfavorite
    Favorite.where("unfavorited = ? AND favorited_at < ?", false, Time.zone.now - 3.days)
  end

  def unfavorite fav
    puts fav.permalink
    begin
      fav.term.user.twitter.unfavorite( [fav.tweet_id] )
    rescue Exception => e
      puts e.message
      # Page no longer exists.
    ensure
      fav.unfavorited = true
      fav.save!
      sleep 0.1
    end
  end

end

# Favorite.where("unfavorited = ? AND favorited_at < ?", false, Time.zone.now - 3.days).find_each { |a| unfavorite a }



#
# Favorite.where("unfavorited = ? AND favorited_at < ?", false, Time.zone.now - 3.days).last(1000).each { |fav| unfav(fav) }
#
# end
#
# def unfav fav
#   begin
#   fav.term.user.twitter.destroy_favorite(fav.tweet_id.to_i)
# rescue Exception => e
#   puts e.message
# ensure
#   fav.unfavorited = true
#   fav.save!
#   puts "Unfaved: #{fav.screen_name} for #{fav.tweet_id}"
#   sleep 0.1
# end
# end