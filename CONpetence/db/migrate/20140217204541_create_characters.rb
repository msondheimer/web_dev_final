class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :franchise
      t.text :cosplaying

      t.timestamps
    end
  end
end
