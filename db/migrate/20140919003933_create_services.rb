class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :short_description
      t.text :body
      t.string :picture

      t.timestamps
    end
  end
end
