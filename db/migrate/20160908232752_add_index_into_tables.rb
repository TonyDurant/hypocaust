class AddIndexIntoTables < ActiveRecord::Migration
  def change
    add_index :lead_times, [:user_id, :construction_site_id]
    add_index :comments, [:user_id, :commentable_id]
    add_index :participations, [:construction_site_id]
  end
end
