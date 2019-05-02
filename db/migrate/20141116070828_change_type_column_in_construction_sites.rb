class ChangeTypeColumnInConstructionSites < ActiveRecord::Migration
  def up
    remove_column :construction_sites, :type
    add_column    :construction_sites, :site_type, :string
  end

  def down
    remove_column :construction_sites, :site_type
    add_column    :construction_sites, :type, :string
  end
end
