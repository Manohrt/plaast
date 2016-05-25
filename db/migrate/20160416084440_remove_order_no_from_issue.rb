class RemoveOrderNoFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :order_no, :string
  end
end
