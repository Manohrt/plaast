class AddUpdatedByToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :updated_by, :string
  end
end
