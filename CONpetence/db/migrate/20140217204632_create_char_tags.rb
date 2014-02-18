class CreateCharTags < ActiveRecord::Migration
  def change
    create_table :char_tags do |t|
      t.integer :photo
      t.integer :character

      t.timestamps
    end
  end
end
