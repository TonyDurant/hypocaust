class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :favorable_id
      t.string  :favorable_type
      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :favorable_id
  end
end
