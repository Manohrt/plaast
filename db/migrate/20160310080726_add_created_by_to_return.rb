class AddCreatedByToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :created_by, :string
  end
end
