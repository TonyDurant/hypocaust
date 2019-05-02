class AddShortDescToPostsTable < ActiveRecord::Migration
  def change
  	add_column :posts, :short_desc, :text
  end
end
