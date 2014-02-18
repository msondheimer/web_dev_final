require 'open-uri'
require 'json'

class Convention < ActiveRecord::Base
	#Go to google to find coords
	#after_save

	before_save :find_coords

	def find_coords
		if self.city == nil
			self.lat = nil
			self.lon = nil
		else
			address = self.city.chomp
			if self.venue != nil
				address = (self.venue.chomp + address)
			end
			address = address.tr(" ", "+")
			json_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=true").read()
			data = JSON.parse(json_data)
			begin
				self.lat = data['results'][0]['geometry']['location']['lat']
				self.lon = data['results'][0]['geometry']['location']['lng']
			rescue NoMethodError
				self.lat = nil
				self.lon = nil
			end
		end
		return self.lat, self.lon
	end


	scope :future, -> {where("end > ?", Time.now).order("start asc")}

	scope :past, -> {where("start < ?", Time.now).order("start desc")}

	def Convention.present
		return Convention.where("start < ? AND end > ?", Time.now, Time.now)
	end
	#scope :present -> 

	scope :genre, ->(gen) {where("genre = ?", gen)}
end
