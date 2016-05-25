class CreateMouldNos < ActiveRecord::Migration
  def change
    create_table :mould_nos do |t|
      t.string :mould_no_list

      t.timestamps null: false
    end
  end
end
