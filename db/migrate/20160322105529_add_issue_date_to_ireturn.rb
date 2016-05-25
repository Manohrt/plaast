class AddIssueDateToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :issue_date, :string
  end
end
