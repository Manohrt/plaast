class AddUpdatedByToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :updated_by, :string
  end
end
