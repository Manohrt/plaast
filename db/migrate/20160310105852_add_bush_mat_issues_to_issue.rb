class AddBushMatIssuesToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_mat_issues, :string
  end
end
