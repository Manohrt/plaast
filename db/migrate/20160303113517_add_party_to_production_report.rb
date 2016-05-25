class AddPartyToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :party, :string
  end
end
