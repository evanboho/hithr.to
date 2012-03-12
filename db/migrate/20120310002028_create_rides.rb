class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :start_city
      t.string :start_state
      t.float :latitude
      t.float :longitude
      t.string :end_city
      t.string :end_state
      t.float :end_lat
      t.float :end_long
      t.float :bearing
      t.float :trip_distance
      t.datetime :go_time
      t.integer :user_id

      t.timestamps
    end
    add_index :rides, :user_id
  end
end
