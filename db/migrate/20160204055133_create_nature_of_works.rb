class CreateNatureOfWorks < ActiveRecord::Migration
  def change
    create_table :nature_of_works do |t|
      t.string :nature_of_work_list

      t.timestamps null: false
    end
  end
end
