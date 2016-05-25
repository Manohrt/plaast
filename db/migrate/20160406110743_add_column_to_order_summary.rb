class AddColumnToOrderSummary < ActiveRecord::Migration
  def change
    add_column :order_summaries, :color_sd, :string
  end
end
