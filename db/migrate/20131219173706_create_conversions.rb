class CreateConversions < ActiveRecord::Migration
  def change
    create_table :conversions do |t|
      t.references :term, index: true
      t.string :screen_name

      t.timestamps
    end
  end
end
