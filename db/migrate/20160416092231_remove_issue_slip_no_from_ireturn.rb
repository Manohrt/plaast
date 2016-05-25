class RemoveIssueSlipNoFromIreturn < ActiveRecord::Migration
  def change
    remove_column :ireturns, :issue_slip_no, :string
  end
end
