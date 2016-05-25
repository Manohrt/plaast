class RemoveOrderNoFromLabour < ActiveRecord::Migration
  def change
    remove_column :labours, :order_no, :string
  end
end
