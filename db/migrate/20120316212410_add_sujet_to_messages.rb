class AddSujetToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sujet, :string

  end
end
