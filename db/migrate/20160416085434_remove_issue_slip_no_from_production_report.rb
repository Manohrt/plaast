class RemoveIssueSlipNoFromProductionReport < ActiveRecord::Migration
  def change
    remove_column :production_reports, :issue_slip_no, :string
  end
end
