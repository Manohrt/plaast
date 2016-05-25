class CreatePartyOrders < ActiveRecord::Migration
  def change
    create_table :party_orders do |t|
      t.string :party_order_list

      t.timestamps null: false
    end
  end
end
