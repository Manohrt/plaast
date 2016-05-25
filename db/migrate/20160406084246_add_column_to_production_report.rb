class AddColumnToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :rejection_reason, :string
  end
end
