class FollowerImporter

  attr_reader :user

  def initialize user
    @user = user
    @followers_in_db = user.followers.pluck(:screen_name)
    @followers_on_twitter = []
  end

  def twitter
    user.twitter
  end

  def import
    import_new_data
    destroy_heretics
  end

  def import_new_data
    follower_ids.each_slice(100).each do |followers|
      twitter.users(followers).each do |follower|
        @followers_on_twitter << follower.screen_name

        if !@followers_in_db.include?(follower.screen_name)
          create_follower(follower)
        end
      end
    end
  end

  def create_follower follower
    user.followers.create!(screen_name: follower.screen_name)
    increment_conversion_for(follower)
  end

  def increment_conversion_for follower
    term_ids = user.favorites.where(screen_name: follower.screen_name).pluck(:term_id).uniq
    Term.find(term_ids).each do |term|
      term.conversions.create! screen_name: follower.screen_name
    end
  end

  def destroy_heretics
    (@followers_in_db - @followers_on_twitter).each do |screen_name|
      heretic = user.followers.find_by_screen_name(screen_name)
      heretic.destroy if heretic
    end
  end

  def follower_ids
    twitter.follower_ids(user.screen_name)
  end

end