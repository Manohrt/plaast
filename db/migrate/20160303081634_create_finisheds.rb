class CreateFinisheds < ActiveRecord::Migration
  def change
    create_table :finisheds do |t|
      t.string :nett_available
      t.string :freight
      t.string :overheads
      t.string :packing_materials
      t.string :spares_used
      t.string :spares_cost

      t.timestamps null: false
    end
  end
end
