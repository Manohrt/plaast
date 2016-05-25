class CreateRawMaterials < ActiveRecord::Migration
  def change
    create_table :raw_materials do |t|
      t.string :raw_material_list

      t.timestamps null: false
    end
  end
end
