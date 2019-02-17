class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :name
      t.text :caption

      t.timestamps
    end
  end
end
