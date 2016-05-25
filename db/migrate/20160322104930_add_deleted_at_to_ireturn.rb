class AddDeletedAtToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :deleted_at, :datetime
  end
end
