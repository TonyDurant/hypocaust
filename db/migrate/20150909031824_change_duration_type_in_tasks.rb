class ChangeDurationTypeInTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :duration
    add_column    :tasks, :duration, :float
  end

  def down
    remove_column :tasks, :duration
    add_column    :tasks, :duration, :integer
  end
end
