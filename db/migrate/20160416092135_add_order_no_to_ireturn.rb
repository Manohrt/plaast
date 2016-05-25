class AddOrderNoToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :order_no, :integer
  end
end
