class AddActionTakenToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :action_taken, :text
  end
end
