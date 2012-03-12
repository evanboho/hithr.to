class AddPhotoUrlToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :photo_url, :string

  end
end
