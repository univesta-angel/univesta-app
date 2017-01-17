class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :body_html
      t.binary :images
      t.text :product_type
      t.text :tags
      t.text :vendor

      t.timestamps
    end
  end
end
