class AddColumnToIreturn < ActiveRecord::Migration
  def change
    add_reference :ireturns, :issue, index: true, foreign_key: true
  end
end
