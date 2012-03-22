class AddSenderEmailToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_email, :string

  end
end
