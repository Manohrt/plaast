class CreateProductionReports < ActiveRecord::Migration
  def change
    create_table :production_reports do |t|
      t.string :finished_goods_name
      t.string :total_no_of_items_produced
      t.string :weight_per_item
      t.string :total_weight_consumed
      t.string :standard_weight
      t.string :no_of_kgs_used_for_production
      t.string :variance
      t.string :rejected_nos
      t.string :weight_per_item
      t.string :rejected_nos_wt_for_re_grounding
      t.string :lumps

      t.timestamps null: false
    end
  end
end
