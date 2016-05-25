class RemoveIssueSlipNoFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :issue_slip_no, :string
  end
end
