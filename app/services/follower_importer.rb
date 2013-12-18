class FollowerImporter

  attr_reader :user

  def initialize user
    @user = user
  end

  def twitter
    user.twitter
  end

  def import
    destroy_old_data
    import_new_data
  end

  def destroy_old_data
    user.followers.destroy_all
  end

  def import_new_data
    follower_ids.each_slice(100).each do |followers|
      twitter.users(followers).each do |follower|
        user.followers.create!(screen_name: follower.screen_name)
      end
    end
  end

  def follower_ids
    twitter.follower_ids(user.screen_name)
  end

end