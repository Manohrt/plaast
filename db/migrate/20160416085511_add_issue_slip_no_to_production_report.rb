class AddIssueSlipNoToProductionReport < ActiveRecord::Migration
  def change
    add_column :production_reports, :issue_slip_no, :integer
  end
end
