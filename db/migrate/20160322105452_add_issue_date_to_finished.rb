class AddIssueDateToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :issue_date, :string
  end
end
