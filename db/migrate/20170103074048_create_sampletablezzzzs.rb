class CreateSampletablezzzzs < ActiveRecord::Migration[5.0]
  def change
    create_table :sampletablezzzzs do |t|
      t.String :name
      t.integer :age
      t.false :id

      t.timestamps
    end
  end
end
