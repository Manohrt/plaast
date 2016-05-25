class AddDeletedAtToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :deleted_at, :datetime
    add_index :purchases, :deleted_at
  end
end
