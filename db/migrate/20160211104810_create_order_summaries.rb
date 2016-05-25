class CreateOrderSummaries < ActiveRecord::Migration
  def change
    create_table :order_summaries do |t|
      t.string :order_no
      t.string :order_date
      t.string :scheduled_date
      t.string :party
      t.string :goods_finished
      t.string :nos
      t.string :ra_material
      t.string :rm_qty_per_item
      t.string :chemicals
      t.string :color_std
      t.string :chemical_qty
      t.string :total_kgs
      t.string :total_rm_kgs
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
