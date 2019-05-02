class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string  :name
      t.string  :attachment
      t.integer :user_id
      t.integer :attachable_id
      t.string  :attachable_type
      t.timestamps
    end
    add_index :attachments, :user_id
    add_index :attachments, :attachable_id
  end
end
