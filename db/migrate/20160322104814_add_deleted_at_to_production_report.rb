class AddDeletedAtToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :deleted_at, :datetime
  end
end
