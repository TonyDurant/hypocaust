class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :body
      t.integer :user_id
      t.integer :commentable_id
      t.string  :commentable_type
      t.string  :file
      t.string  :status
      t.timestamps
    end
  end
end
