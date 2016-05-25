class AddCreatedByToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :created_by, :string
  end
end
