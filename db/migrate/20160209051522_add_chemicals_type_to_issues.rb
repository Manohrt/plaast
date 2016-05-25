class AddChemicalsTypeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :chemicals_type, :string
  end
end
