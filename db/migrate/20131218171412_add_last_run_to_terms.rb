class AddLastRunToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :last_run, :datetime, default: '2013-01-01'
  end
end
