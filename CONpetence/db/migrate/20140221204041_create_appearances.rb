class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.integer :character_id
      t.integer :franchise_id

      t.timestamps
    end
  end
end
