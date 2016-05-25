class CreateRejectionReasons < ActiveRecord::Migration
  def change
    create_table :rejection_reasons do |t|
      t.string :rejection_reason_list

      t.timestamps null: false
    end
  end
end
