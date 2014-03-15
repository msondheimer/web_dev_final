class AddCoordsToConventions < ActiveRecord::Migration
  def change
    add_column :conventions, :lat, :float
    add_column :conventions, :lon, :float
  end
end
