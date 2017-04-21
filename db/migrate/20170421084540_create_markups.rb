class CreateMarkups < ActiveRecord::Migration[5.0]
  def change
    create_table :markups do |t|
      t.float :price
      t.float :compare_at_price
      t.string :operator1
      t.string :operator2
      t.boolean :capToggle

      t.timestamps
    end
  end
end
