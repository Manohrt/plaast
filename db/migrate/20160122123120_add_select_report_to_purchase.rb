class AddSelectReportToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :select_report, :string
  end
end
