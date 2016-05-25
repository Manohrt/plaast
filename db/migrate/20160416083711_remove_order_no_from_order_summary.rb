class RemoveOrderNoFromOrderSummary < ActiveRecord::Migration
  def change
    remove_column :order_summaries, :order_no, :string
  end
end
