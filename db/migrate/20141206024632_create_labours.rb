class CreateLabours < ActiveRecord::Migration
  def change
    create_table :labours do |t|
      t.string  :name
      t.string  :product_id
      t.string  :system_id
      t.string  :unit
      t.float   :price
      t.string  :description
      t.integer :service_id
      t.integer :user_id
      t.integer :currency
      t.timestamps
    end
    add_index :labours, :product_id
    add_index :labours, :system_id
    add_index :labours, :service_id
    add_index :labours, :user_id
  end
end
