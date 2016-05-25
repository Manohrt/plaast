class AddUpdatedByToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :updated_by, :string
  end
end
