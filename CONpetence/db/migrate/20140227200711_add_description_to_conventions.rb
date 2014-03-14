class AddDescriptionToConventions < ActiveRecord::Migration
  def change
  	add_column :conventions, :description, :text
  end
end
