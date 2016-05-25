class AddBushQtyReturnToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_qty_return, :string
  end
end
