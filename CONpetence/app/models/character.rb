class Character < ActiveRecord::Base
	has_many :char_tags, foreign_key: "character"
	has_many :photos, through: :char_tags
end
