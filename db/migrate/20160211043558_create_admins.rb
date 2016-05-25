class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :order_party
      t.string :purchase_party
      t.string :chem
      t.string :chem_typ
      t.string :ra_material
      t.string :mouldno
      t.string :finishgoods
      t.string :mach_use
      t.string :reason_idle
      t.string :work_nature

      t.timestamps null: false
    end
  end
end
