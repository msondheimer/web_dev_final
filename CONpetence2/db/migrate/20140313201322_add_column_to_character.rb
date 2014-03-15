class AddColumnToCharacter < ActiveRecord::Migration
  def change
  	add_column :characters, :cosplay, :text
  end
end
