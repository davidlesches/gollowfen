class NuclearScrubber

  ORDER_SCOPE = "favorites.id desc"

  attr_reader :user

  def initialize user
    @user = user
    @count = 0
    scrub
  end

  def scrub
    ids = user.favorites.where('unfavorited = ?', false).order(ORDER_SCOPE).pluck(:id)
    ids.each_slice(500) do |chunk|
      Favorite.find(chunk).order(ORDER_SCOPE).each do |tweet|
        thwak tweet
      end
    end
  end

  def thwak fav
    begin
      puts "COUNT #{@count += 1} | ID #{fav.id} | #{fav.permalink}"
      user.twitter.unfavorite(fav.tweet_id.to_i)
      fav.unfavorited = true
      fav.save!
    rescue Exception => e
      # do nothing
      puts e.message
    end
    sleep 0.5
  end

end

