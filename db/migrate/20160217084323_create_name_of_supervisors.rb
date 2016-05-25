class CreateNameOfSupervisors < ActiveRecord::Migration
  def change
    create_table :name_of_supervisors do |t|
      t.string :name_of_supervisor_list

      t.timestamps null: false
    end
  end
end
