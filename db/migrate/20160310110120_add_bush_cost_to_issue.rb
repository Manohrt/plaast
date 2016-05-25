class AddBushCostToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :bush_cost, :string
  end
end
