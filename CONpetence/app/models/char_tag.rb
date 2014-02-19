class CharTag < ActiveRecord::Base
	belongs_to :photo, foreign_key: "photo"
	belongs_to :character, foreign_key: "character"
end
