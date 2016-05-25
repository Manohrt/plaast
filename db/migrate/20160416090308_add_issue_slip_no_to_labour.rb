class AddIssueSlipNoToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :issue_slip_no, :integer
  end
end
