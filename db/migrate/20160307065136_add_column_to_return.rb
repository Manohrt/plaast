class AddColumnToReturn < ActiveRecord::Migration
  def change
    add_reference :returns, :issue, index: true, foreign_key: true
  end
end
