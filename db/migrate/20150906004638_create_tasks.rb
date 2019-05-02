class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   :name
      t.text     :desc
      t.integer  :duration
      t.datetime :start_time
      t.string   :state
      t.integer  :construction_site_id
      t.integer  :user_id
      t.integer  :sprint_id
      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :construction_site_id
    add_index :tasks, :sprint_id
  end
end
