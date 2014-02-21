class Franchise < ActiveRecord::Base
	has_many :characters, through: :appearance 
end
