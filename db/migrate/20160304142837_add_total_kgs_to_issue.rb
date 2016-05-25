class AddTotalKgsToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :total_kgs, :string
  end
end
