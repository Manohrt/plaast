class AddColunmToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :total_no_of_items_produced, :string
  end
end
