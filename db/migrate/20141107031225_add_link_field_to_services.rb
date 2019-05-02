class AddLinkFieldToServices < ActiveRecord::Migration
  def change
  	add_column :services, :link, :string
  end
end
