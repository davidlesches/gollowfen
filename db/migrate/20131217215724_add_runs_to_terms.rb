class AddRunsToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :runs, :integer, default: 0
  end
end
