class CreateSampletables < ActiveRecord::Migration[5.0]
  def change
    create_table :sampletables do |t|
      t.String :name
      t.integer :age

      t.timestamps
    end
  end
end
