class AddRmMatQtyToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :rm_mat_qty, :string
  end
end
