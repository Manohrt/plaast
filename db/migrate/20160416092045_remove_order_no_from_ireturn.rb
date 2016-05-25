class RemoveOrderNoFromIreturn < ActiveRecord::Migration
  def change
    remove_column :ireturns, :order_no, :string
  end
end
