class CreateChemicalTypes < ActiveRecord::Migration
  def change
    create_table :chemical_types do |t|
      t.string :chemical_type_list

      t.timestamps null: false
    end
  end
end
