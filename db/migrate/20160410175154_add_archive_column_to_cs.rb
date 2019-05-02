class AddArchiveColumnToCs < ActiveRecord::Migration
  def change
  	remove_column :construction_sites, :archive
  	add_column :construction_sites, :archive, :boolean, default: false
  end
end
