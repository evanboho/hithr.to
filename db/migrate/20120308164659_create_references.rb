class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :user_id
      t.integer :sender_id
      t.text :content
      t.integer :positive

      t.timestamps
    end
    add_index :references, :user_id
    add_index :references, :sender_id
  end
end
