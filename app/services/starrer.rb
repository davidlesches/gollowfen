class Starrer

  attr_reader :term, :user, :followers

  def initialize term
    @term      = term
    @user      = term.user
    @followers = user.followers
  end

  def twitter
    user.twitter
  end

  def star
    twitter.search(term.term, count: 40, result_type: "recent").each do |tweet|
      favorite(tweet) unless follows_me?(tweet) || favorited?(tweet)
    end
  end

  def favorited? tweet
    Favorite.where("screen_name = ? AND favorited_at > ? AND term_id IN (?)", tweet.user.screen_name, Time.zone.now - 3.weeks, all_term_ids).any?
  end

  def favorite tweet
    begin
      unless tweet.favorited
        twitter.favorite!(tweet)
        Favorite.create!(
          :term_id      => term.id,
          :favorited_at => Time.zone.now,
          :text         => tweet.text,
          :screen_name  => tweet.user.screen_name,
          :permalink    => "https://twitter.com/#{tweet.user.screen_name}/statuses/#{tweet.id}"
        )
      end
    rescue Twitter::Error::Forbidden
    end
  end

  def follows_me? tweet
    user.followers.exists?(screen_name: tweet.user.screen_name)
  end

  def all_term_ids
    user.term_ids
  end

end