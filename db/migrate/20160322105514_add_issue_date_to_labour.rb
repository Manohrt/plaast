class AddIssueDateToLabour < ActiveRecord::Migration
  def change
    add_column :labours, :issue_date, :string
  end
end
