class AddColumnToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :total_iss, :string
  end
end
