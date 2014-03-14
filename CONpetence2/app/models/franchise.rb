class Franchise < ActiveRecord::Base
	has_many :appearances, dependent: :destroy
	has_many :characters, through: :appearances 
end
