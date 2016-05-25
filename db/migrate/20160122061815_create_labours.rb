class CreateLabours < ActiveRecord::Migration
  def change
    create_table :labours do |t|
      t.string :order_no
      t.string :nature
      t.string :difference
      t.string :dated
      t.string :rate_per_person
      t.string :efficiency
      t.string :party
      t.string :cost_per_shift
      t.string :no_of_hrs_idle
      t.string :issue_slip_no
      t.string :finished_goods_name
      t.string :no_of_mins_idle
      t.string :date
      t.string :no_of_item_produced
      t.string :reasons_for_idle
      t.string :machine_used
      t.string :weight_in_gms
      t.string :idle_time_reasons_desc
      t.string :mould_no
      t.string :no_of_cavity
      t.string :spares_name
      t.string :shift
      t.string :cycle_time
      t.string :spares_cost
      t.string :no_of_persons
      t.string :working_hrs
      t.string :supervisor_name
      t.string :other_work
      t.string :expected_production

      t.timestamps null: false
    end
  end
end
