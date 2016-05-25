class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :month
      t.string :item
      t.string :bill_value
      t.string :grn_no
      t.string :desc
      t.string :rate
      t.string :date
      t.string :order_no
      t.string :debit
      t.string :party
      t.string :qty_accepted
      t.string :reasons
      t.string :trading_material
      t.string :rejected

      t.timestamps null: false
    end
  end
end
