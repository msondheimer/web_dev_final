class Character < ActiveRecord::Base
	has_many :char_tags
	has_many :photos, through: :char_tags
	has_many :franchise, through: :appearance 
end
