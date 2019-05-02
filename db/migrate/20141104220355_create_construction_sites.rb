class CreateConstructionSites < ActiveRecord::Migration
  def change
    create_table :construction_sites do |t|
      t.string :name
      t.string :address
      t.string :customer_name
      t.string :email
      t.string :phone
      t.string :type
      t.float :area
      t.string :avatar
      t.integer :customer_id
      t.integer :manager_id
      t.text :description

      t.timestamps
    end
  end
end
