class CreatePartyPurchases < ActiveRecord::Migration
  def change
    create_table :party_purchases do |t|
      t.string :party_purchase_list

      t.timestamps null: false
    end
  end
end
