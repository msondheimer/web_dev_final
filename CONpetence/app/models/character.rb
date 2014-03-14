class Character < ActiveRecord::Base
	has_many :char_tags, dependent: :destroy
	has_many :photos, through: :char_tags
	has_many :appearances, dependent: :destroy
	has_many :franchises, through: :appearances 

	def franchise_names
		a = franchises.order("name asc").pluck(:name)
		fs = ""
		a.each do |n|
			fs += "#{n}, "
		end
		return fs.chop.chop
	end

end
