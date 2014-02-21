class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.text :cosplaying
      t.integer :character_group_id
      t.timestamps
    end
  end
end
