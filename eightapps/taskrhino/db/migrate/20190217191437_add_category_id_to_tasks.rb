class AddCategoryIdToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :category_id, :integer
  end
end
