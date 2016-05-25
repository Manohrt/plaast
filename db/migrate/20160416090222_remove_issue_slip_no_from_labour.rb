class RemoveIssueSlipNoFromLabour < ActiveRecord::Migration
  def change
    remove_column :labours, :issue_slip_no, :string
  end
end
