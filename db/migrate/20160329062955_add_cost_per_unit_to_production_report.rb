class AddCostPerUnitToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :cost_per_unit, :string
  end
end
