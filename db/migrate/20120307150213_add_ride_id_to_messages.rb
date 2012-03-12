class AddRideIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :ride_id, :integer

  end
end
