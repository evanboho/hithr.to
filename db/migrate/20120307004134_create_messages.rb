class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :user_id
      t.integer :ride_id
      t.text :content
      t.boolean :read

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :sender_id
  end
end
