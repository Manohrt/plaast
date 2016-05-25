class AddCreatedByToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :created_by, :string
  end
end
