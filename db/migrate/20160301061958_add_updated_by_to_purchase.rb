class AddUpdatedByToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :updated_by, :string
  end
end
