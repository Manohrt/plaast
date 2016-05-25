class AddOrderNoToOrderSummary < ActiveRecord::Migration
  def change
    add_column :order_summaries, :order_no, :integer
  end
end
