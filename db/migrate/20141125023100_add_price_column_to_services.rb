class AddPriceColumnToServices < ActiveRecord::Migration
  def change
  	add_column :services, :price, :string
  end
end
