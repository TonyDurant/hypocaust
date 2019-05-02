class AddColumnToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :blog_id, :integer
  	add_index :posts, :blog_id
  end
end
