class AddQtytoProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :avail_qty, :integer, array: true
  end
end