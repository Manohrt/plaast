class AddOrderNoToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :order_no, :integer
  end
end
