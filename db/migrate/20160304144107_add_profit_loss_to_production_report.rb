class AddProfitLossToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :profit_loss, :string
  end
end
