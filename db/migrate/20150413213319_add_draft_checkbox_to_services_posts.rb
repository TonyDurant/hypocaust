class AddDraftCheckboxToServicesPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :draft, :boolean
  	add_column :services, :draft, :boolean
  end
end
