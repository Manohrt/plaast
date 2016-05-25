class CreateMachineNos < ActiveRecord::Migration
  def change
    create_table :machine_nos do |t|
      t.string :machine_no_list

      t.timestamps null: false
    end
  end
end
