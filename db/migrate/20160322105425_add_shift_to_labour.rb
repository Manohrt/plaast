class AddShiftToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :shift, :string
  end
end
