class AddCreatedByToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :created_by, :string
  end
end
