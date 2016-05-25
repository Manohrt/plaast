class CreateChemicals < ActiveRecord::Migration
  def change
    create_table :chemicals do |t|
      t.string :chemical_list

      t.timestamps null: false
    end
  end
end
