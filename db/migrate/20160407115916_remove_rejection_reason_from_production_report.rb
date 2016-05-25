class RemoveRejectionReasonFromProductionReport < ActiveRecord::Migration
  def change
    remove_column :production_reports, :rejection_reason, :string
  end
end
