class NuclearScrubber

  attr_reader :user

  def initialize user
    @user = user
    @count = 0
    scrub
  end

  def scrub
    user.favorites.where('unfavorited = ?', false).order('id desc').find_each do |tweet|
      puts(@count += 1)
      thwak tweet
    end
  end

  def thwak fav
    begin
      puts fav.permalink
      user.twitter.unfavorite(fav.tweet_id.to_i)
      fav.unfavorited = true
      fav.save!
    rescue Exception => e
      # do nothing
      puts e.message
    end
    sleep 1
  end

end

