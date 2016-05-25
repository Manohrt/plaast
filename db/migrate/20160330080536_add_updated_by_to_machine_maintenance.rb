class AddUpdatedByToMachineMaintenance < ActiveRecord::Migration
  def change
    add_column :machine_maintenances, :updated_by, :string
  end
end
