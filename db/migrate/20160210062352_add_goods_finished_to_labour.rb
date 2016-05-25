class AddGoodsFinishedToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :goods_finished, :string
  end
end
