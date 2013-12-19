class AddCounterForConversions < ActiveRecord::Migration
  def change
    rename_column :terms, :conversions, :conversions_count
  end
end
