class CreateCharTags < ActiveRecord::Migration
  def change
    create_table :char_tags do |t|
      t.integer :photo_id
      t.integer :character_id

      t.timestamps
    end
  end
end
