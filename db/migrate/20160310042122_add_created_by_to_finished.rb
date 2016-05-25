class AddCreatedByToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :created_by, :string
  end
end
