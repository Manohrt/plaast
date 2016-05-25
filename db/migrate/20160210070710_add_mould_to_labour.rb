class AddMouldToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :mould, :string
  end
end
