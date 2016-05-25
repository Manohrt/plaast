class AddShiftToIreturn < ActiveRecord::Migration
  def change
    add_column :ireturns, :shift, :string
  end
end
