class AddCreatedByToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :created_by, :string
  end
end
