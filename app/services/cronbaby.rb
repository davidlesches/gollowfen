class Cronbaby

  def self.run_favorites
    User.find_each do |user|
      user.terms.next_queued.favorite
    end
  end

  def self.import_followers
    User.find_each do |user|
      user.import_followers
    end
  end

end