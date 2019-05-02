class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string  :name
      t.float   :remain_hours
      t.integer :sprint_id
      t.timestamps
    end
    add_index :metrics, :sprint_id
  end
end
