class CreateFinishedGoodsNames < ActiveRecord::Migration
  def change
    create_table :finished_goods_names do |t|
      t.string :finished_goods_name_list

      t.timestamps null: false
    end
  end
end
