class CreateRegrounds < ActiveRecord::Migration
  def change
    create_table :regrounds do |t|
      t.string :reground_list

      t.timestamps null: false
    end
  end
end
