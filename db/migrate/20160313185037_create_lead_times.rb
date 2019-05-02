class CreateLeadTimes < ActiveRecord::Migration
  def change
    create_table :lead_times do |t|
      t.string :title
      t.string :user_id
      t.string :construction_site_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
