class AddDetailsToOrderSummary < ActiveRecord::Migration
  def change
    add_column :order_summaries, :created_by, :string
    add_column :order_summaries, :updated_by, :string
  end
end
