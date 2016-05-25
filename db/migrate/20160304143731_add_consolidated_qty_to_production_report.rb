class AddConsolidatedQtyToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :consolidated_qty, :string
  end
end
