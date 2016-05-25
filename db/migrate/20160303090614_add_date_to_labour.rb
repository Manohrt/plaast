class AddDateToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :date, :string
  end
end
