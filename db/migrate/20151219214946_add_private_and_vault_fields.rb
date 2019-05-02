class AddPrivateAndVaultFields < ActiveRecord::Migration
  def change
    add_column :construction_sites, :vault, :boolean, null: false, default: false
    add_column :construction_sites, :public, :boolean, null: false, default: false
  end
end
