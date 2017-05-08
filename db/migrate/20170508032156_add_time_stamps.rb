class AddTimeStamps < ActiveRecord::Migration[5.0]
  def self.up
  	change_table :markups do |t|
        t.timestamps
    end
  end
end
