class AddUpdatedByToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :updated_by, :string
  end
end
