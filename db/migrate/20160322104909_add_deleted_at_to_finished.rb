class AddDeletedAtToFinished < ActiveRecord::Migration
  def change
    add_column :finisheds, :deleted_at, :datetime
  end
end
