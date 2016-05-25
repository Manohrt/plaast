class AddSellingPriceToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :selling_price, :string
  end
end
