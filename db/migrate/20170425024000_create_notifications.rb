class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :product_title
      t.string :product_salePrice
      t.string :product_originalPrice
      t.bigint :ae_productid
      t.bigint :shopify_productid

      t.timestamps
    end
  end
end
