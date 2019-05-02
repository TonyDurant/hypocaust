class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string  :name
      t.string  :desc
      t.integer :construction_site_id
      t.integer :user_id
      t.timestamps
    end
    add_index :sprints, :construction_site_id
    add_index :sprints, :user_id
  end
end
