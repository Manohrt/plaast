class CreateMachineUseds < ActiveRecord::Migration
  def change
    create_table :machine_useds do |t|
      t.string :machine_used_list

      t.timestamps null: false
    end
  end
end
