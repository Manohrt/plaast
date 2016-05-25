class AddBushRateToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_rate, :string
  end
end
