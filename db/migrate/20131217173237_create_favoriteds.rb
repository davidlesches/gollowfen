class CreateFavoriteds < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :term, index: true
      t.datetime :favorited_at
      t.string :text
      t.string :screen_name
      t.string :permalink

      t.timestamps
    end
  end
end
