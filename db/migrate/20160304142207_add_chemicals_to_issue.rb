class AddChemicalsToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :chemicals, :string
  end
end
