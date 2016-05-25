class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :order_no
      t.string :order_date
      t.string :type
      t.string :color_issues
      t.string :rm_qty
      t.string :che_qty
      t.string :rg_qty
      t.string :party
      t.string :issue_slip_no
      t.string :issue_date
      t.string :machine_no
      t.string :shift
      t.string :chem_qty
      t.string :chem_qty_return
      t.string :chem_rate
      t.string :generated
      t.string :lumps
      t.string :qty_after_rg
      t.string :rm_issues
      t.string :rm_qty
      t.string :rm_consume
      t.string :rm_qty_return
      t.string :rm_rate
      t.string :rg_material_issues
      t.string :rg_qty_issued
      t.string :rg_qty_return
      t.string :rg_consume
      t.string :rg_rate
      t.string :rm_cost
      t.string :che_cost
      t.string :rg_cost
      t.string :consolidated_qty
      t.string :consolidated_cost

      t.timestamps null: false
    end
  end
end
