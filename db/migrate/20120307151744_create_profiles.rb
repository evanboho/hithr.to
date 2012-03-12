class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :gender
      t.string :hometown
      t.text :about
      t.integer :user_id
      t.integer :cred

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
