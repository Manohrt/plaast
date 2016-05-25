class AddColumnToFinished < ActiveRecord::Migration
  def change
    add_reference :finisheds, :labour, index: true, foreign_key: true
  end
end
