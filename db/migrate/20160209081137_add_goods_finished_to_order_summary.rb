class AddGoodsFinishedToOrderSummary < ActiveRecord::Migration
  def change
    add_column :order_summaries, :goods_finished, :string
  end
end
