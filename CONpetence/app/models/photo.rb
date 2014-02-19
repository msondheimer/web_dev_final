class Photo < ActiveRecord::Base

	belongs_to :convention, foreign_key: "con"

	has_many :char_tags, foreign_key: "photo"
	has_many :characters, through: :char_tags
end
