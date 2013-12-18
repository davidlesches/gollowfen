class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references :user, index: true
      t.string :term

      t.timestamps
    end
  end
end
