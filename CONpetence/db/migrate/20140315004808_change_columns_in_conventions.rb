class ChangeColumnsInConventions < ActiveRecord::Migration
  def change
  	rename_column :conventions, :end, :end_date
  end
end
