class AddIssueSlipNoToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :issue_slip_no, :integer
  end
end
