class AddTimeStamps < ActiveRecord::Migration[5.0]
  def self.up
  	change_table :markups do |t|
        t.timestamps default: Time.now
    end
  end
end
