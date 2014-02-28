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
				address += "+#{self.venue.chomp}"
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
		return data
	end

	def Convention.genres
		return ['Anime', 'Comics', 'Sci-Fi', 'Gaming', 'Steampunk', 'Specific Franchise', 'Multigenre', 'Horror'].sort
	end
	def Convention.genre_opts
		# if Convention.genres == 'All'
		# 	return Convention.genres.zip
		# end
		return Convention.genres.zip(Convention.genres)
	end

	scope :future, -> {where("end >= ?", Time.now).order("start asc")}

	scope :past, -> {where("start <= ?", Time.now).order("start desc")}

	scope :present, ->{future.past} 

	def Convention.genre(gen)
		if gen == 'All'
			all().order("start asc")
		else
			where("genre = ?", gen).order("start asc")
		end
	end

	scope :has_time, -> {where.not(start: nil)}

	def Convention.next(name) 
		Convention.future.find_by(name: "#{name}")
	end

	has_many :photos

	def is_within(lat, lon, dist)
		lat_dist = (self.lat - lat) * 24859.82 / 360 
		circ_at_lat = Math.cos(self.lat * Math::PI / 180) * 24901.55
		lon_dist = (self.lon - lon) * circ_at_lat / 360
		return Math.sqrt(lat_dist**2 + lon_dist**2) <= dist
	end

	# def Convention.within(location, dist){
	# 	loc = location.chomp
	# 	loc = loc.tr(" ", "+")

	# 	#Get info from google.
	# 	json_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&sensor=true").read()
	# 	data = JSON.parse(json_data)

	# 	#Print the info.
	# 	begin
	# 		coord_lat = data['results'][0]['geometry']['location']['lat']
	# 		coord_lon = data['results'][0]['geometry']['location']['lng']
	# 	rescue NoMethodError
	# 		return Convention.where(id: -1)
	# 	end
	# 	return Covnetion.where
	# }
end
