class Appearance < ActiveRecord::Base
	belongs_to :character
	belongs_to :franchise
end
