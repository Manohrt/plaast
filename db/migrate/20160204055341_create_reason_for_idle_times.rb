class CreateReasonForIdleTimes < ActiveRecord::Migration
  def change
    create_table :reason_for_idle_times do |t|
      t.string :reason_for_idle_time_list

      t.timestamps null: false
    end
  end
end
