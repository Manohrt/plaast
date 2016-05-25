class CreateTypeOfPurchases < ActiveRecord::Migration
  def change
    create_table :type_of_purchases do |t|
      t.string :purchase_type

      t.timestamps null: false
    end
  end
end
