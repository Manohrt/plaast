class AddUpdatedByToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :updated_by, :string
  end
end
