class AddBushQtyIssuedToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_qty_issued, :string
  end
end
