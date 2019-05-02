class AddColorForTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :color, :string, default: "info"
  end
end
