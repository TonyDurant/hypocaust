class ChangeManagerIdToUserId < ActiveRecord::Migration
  def up
    remove_column :construction_sites, :manager_id
    add_column    :construction_sites, :user_id, :integer
  end

  def down
    remove_column :construction_sites, :user_id
    add_column    :construction_sites, :manager_id, :integer
  end
end
