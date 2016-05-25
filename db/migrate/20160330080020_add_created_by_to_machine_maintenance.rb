class AddCreatedByToMachineMaintenance < ActiveRecord::Migration
  def change
    add_column :machine_maintenances, :created_by, :string
  end
end
