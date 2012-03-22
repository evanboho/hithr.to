class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :genre
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
