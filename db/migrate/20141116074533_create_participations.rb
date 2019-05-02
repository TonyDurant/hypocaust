class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :construction_site_id
      t.string  :role
      t.timestamps
    end
  end
end
