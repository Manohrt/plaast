class AddOrderNoToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :order_no, :integer
  end
end
