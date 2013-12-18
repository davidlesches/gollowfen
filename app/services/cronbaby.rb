class Cronbaby

  def self.run_favorites
    User.find_each do |user|
      user.terms.find_each do { |t| t.favorite }
    end
  end

  def self.import_followers
    User.find_each do |user|
      user.import_followers
    end
  end

end