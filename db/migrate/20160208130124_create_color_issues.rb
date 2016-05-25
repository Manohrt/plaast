class CreateColorIssues < ActiveRecord::Migration
  def change
    create_table :color_issues do |t|
      t.string :color_issue_list

      t.timestamps null: false
    end
  end
end
