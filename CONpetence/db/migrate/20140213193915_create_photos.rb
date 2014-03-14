class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_url
      t.integer :convention_id
      t.integer :posting_user

      t.timestamps
    end
  end
end
