class AddQtyReceivedToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :qty_received, :string
  end
end
