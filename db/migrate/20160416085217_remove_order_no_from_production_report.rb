class RemoveOrderNoFromProductionReport < ActiveRecord::Migration
  def change
    remove_column :production_reports, :order_no, :string
  end
end
