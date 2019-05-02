class ArchiveProject < ActiveRecord::Migration
  def change
  	add_column :construction_sites, :archive, :boolean
  end
end
