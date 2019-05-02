class CorrectNullProblemMigrationForPostsAndServices < ActiveRecord::Migration
  def down
    remove_column :posts, :draft
    remove_column :services, :draft
    add_column    :posts, 	 :draft, :boolean
    add_column	  :services, :draft, :boolean
  end

  def up
  	remove_column :posts, 	 :draft
    remove_column :services, :draft
    add_column    :posts, 	 :draft, :boolean, null: false, default: false
    add_column	  :services, :draft, :boolean, null: false, default: false
  end
end
