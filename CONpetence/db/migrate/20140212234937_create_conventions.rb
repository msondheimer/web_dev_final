class CreateConventions < ActiveRecord::Migration
  def change
    create_table :conventions do |t|
      t.string :name
      t.string :genre
      t.string :city
      t.string :venue
      t.string :con_url
      t.integer :expected_size
      t.datetime :start
      t.datetime :end
      t.string :logo_url

      t.timestamps
    end
  end
end
