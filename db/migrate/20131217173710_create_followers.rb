class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :user, index: true
      t.string :screen_name

      t.timestamps
    end
  end
end
