class RemoveOrderNoFromFinished < ActiveRecord::Migration
  def change
    remove_column :finisheds, :order_no, :string
  end
end
