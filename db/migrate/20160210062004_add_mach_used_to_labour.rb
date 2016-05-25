class AddMachUsedToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :mach_used, :string
  end
end
