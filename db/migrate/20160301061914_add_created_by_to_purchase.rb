class AddCreatedByToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :created_by, :string
  end
end
