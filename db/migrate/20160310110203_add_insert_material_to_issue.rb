class AddInsertMaterialToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :insert_material, :string
  end
end
