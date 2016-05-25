class AddDateToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :date, :string
  end
end
