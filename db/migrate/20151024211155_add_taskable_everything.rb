class AddTaskableEverything < ActiveRecord::Migration
  def change
    add_column :tasks, :taskable_id,   :integer
    add_column :tasks, :taskable_type, :string
    add_index  :tasks, :taskable_id
  end
end
