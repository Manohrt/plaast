class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :cost_per_unit

      t.timestamps null: false
    end
  end
end
