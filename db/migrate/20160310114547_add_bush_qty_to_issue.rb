class AddBushQtyToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_qty, :string
  end
end
