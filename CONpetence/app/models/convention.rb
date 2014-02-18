class Convention < ActiveRecord::Base
	#Go to google to find coords
	#after_save

	scope :future, -> {where("end > ?", Time.now).order("start asc")}

	scope :past, -> {where("start < ?", Time.now).order("start desc")}

	def Convention.present
		return Convention.where("start < ? AND end > ?", Time.now, Time.now)
	end
	scope :present -> 

	scope :genre, ->(gen) {where("genre = ?", gen)}
end
