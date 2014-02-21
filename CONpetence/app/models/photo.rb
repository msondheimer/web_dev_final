class Photo < ActiveRecord::Base

	has_attached_file :picture
	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

	belongs_to :convention, foreign_key: "con"

	has_many :char_tags, foreign_key: "photo"
	has_many :characters, through: :char_tags
end
