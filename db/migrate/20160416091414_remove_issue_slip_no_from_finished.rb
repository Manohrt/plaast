class RemoveIssueSlipNoFromFinished < ActiveRecord::Migration
  def change
    remove_column :finisheds, :issue_slip_no, :string
  end
end
