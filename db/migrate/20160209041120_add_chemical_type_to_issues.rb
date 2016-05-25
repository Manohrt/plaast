class AddChemicalTypeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :chemical_type, :string
  end
end
