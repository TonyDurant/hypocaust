class CreateLinkThumbnails < ActiveRecord::Migration
  def change
    create_table :link_thumbnails do |t|
      t.string  :name
      t.string  :favicon
      t.text    :desc
      t.string  :image
      t.integer :comment_id
      t.string  :url

      t.timestamps
    end
    add_index :link_thumbnails, [:comment_id]
  end
end
