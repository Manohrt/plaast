class AddShiftToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :shift, :string
  end
end
