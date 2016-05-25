class AddOrderNoToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :order_no, :integer
  end
end
