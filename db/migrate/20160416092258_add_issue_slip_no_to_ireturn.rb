class AddIssueSlipNoToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :issue_slip_no, :integer
  end
end
