class AddColumnToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :pro_time, :string
  end
end
