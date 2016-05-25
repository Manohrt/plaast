class AddDeletedAtToMachineMaintenance < ActiveRecord::Migration
  def change
    add_column :machine_maintenances, :deleted_at, :datetime
    add_index :machine_maintenances, :deleted_at
  end
end
