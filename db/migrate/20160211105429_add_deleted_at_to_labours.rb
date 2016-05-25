class AddDeletedAtToLabours < ActiveRecord::Migration
  def change
    add_column :labours, :deleted_at, :datetime
    add_index :labours, :deleted_at
  end
end
