class AddConversionsToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :conversions, :integer, default: 0
  end
end
