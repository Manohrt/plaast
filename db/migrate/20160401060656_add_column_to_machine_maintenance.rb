class AddColumnToMachineMaintenance < ActiveRecord::Migration
  def change
    add_column :machine_maintenances, :date, :string
  end
end
