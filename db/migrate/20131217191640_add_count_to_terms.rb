class AddCountToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :favorites_count, :integer, default: 0
  end
end
