class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :seats_available
      t.integer :cost
      t.string :radio
      t.integer :smoking
      t.integer :bikes
      t.text :message
      t.string :confirmed_riders
      t.integer :ride_id

      t.timestamps
    end
    add_index :details, :ride_id
  end
end
