class CreateIreturns < ActiveRecord::Migration
  def change
    create_table :ireturns do |t|
      t.string :grn_no

      t.timestamps null: false
    end
  end
end
