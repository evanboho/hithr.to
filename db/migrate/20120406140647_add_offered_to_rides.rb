class AddOfferedToRides < ActiveRecord::Migration
  def change
    add_column :rides, :offered, :boolean
  end
end
