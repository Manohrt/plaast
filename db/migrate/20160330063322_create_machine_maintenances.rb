class CreateMachineMaintenances < ActiveRecord::Migration
  def change
    create_table :machine_maintenances do |t|
      t.string :mach_no
      t.string :type_of_prob
      t.string :spare_name
      t.string :spare_cost

      t.timestamps null: false
    end
  end
end
