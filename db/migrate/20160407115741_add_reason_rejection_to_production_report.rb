class AddReasonRejectionToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :reason_rejection, :string
  end
end
