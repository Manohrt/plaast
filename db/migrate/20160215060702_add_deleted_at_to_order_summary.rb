class AddDeletedAtToOrderSummary < ActiveRecord::Migration
  def change
    add_column :order_summaries, :deleted_at, :datetime
  end
end
