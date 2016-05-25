class AddUpdatedByToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :updated_by, :string
  end
end
