class AddOrderNoToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :order_no, :integer
  end
end
