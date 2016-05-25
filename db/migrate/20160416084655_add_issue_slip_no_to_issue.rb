class AddIssueSlipNoToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :issue_slip_no, :integer
  end
end
