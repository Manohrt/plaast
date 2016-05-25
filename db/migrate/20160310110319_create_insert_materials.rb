class CreateInsertMaterials < ActiveRecord::Migration
  def change
    create_table :insert_materials do |t|
      t.string :insert_material_list

      t.timestamps null: false
    end
  end
end
