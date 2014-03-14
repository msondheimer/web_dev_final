class CharTag < ActiveRecord::Base
	belongs_to :photo
	belongs_to :character

	around_save :unique_key

	def unique_key
		if CharTag.find_by(photo: self.photo, character: self.character)
			self.destroy
		else
			yield
		end
	end
end
