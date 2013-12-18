class AddUnfavoritedToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :unfavorited, :boolean, default: false
    add_column :favorites, :tweet_id, :string
  end
end
