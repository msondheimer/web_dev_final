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

	def Convention.search_name(substring)
		mod_string = substring.downcase.gsub(/\W+/, '')
		names_array = []
		all_list.each do |n_l|
			if n_l.name.downcase.gsub(/\W+/, '').include?(mod_string)
				names_array += [n_l.id]
			end
		end
		#puts names_array
		return search_array(names_array)
	end



	scope :all_list, -> {all}
	scope :search_array, -> (arr) {where(id: arr)}

	scope :after, -> (date) {where("end >= ?", Date::strptime(date, "%Y-%m-%d")).order("start asc")}

	scope :before, -> (date) {where("start <= ?", Date::strptime(date, "%Y-%m-%d")).order("start asc")}

	def Convention.next(name) 
		future.find_by(name: "#{name}")
	end

	has_many :photos

	def distance(lat, lon)
		lat_dist = (self.lat - lat) * 24859.82 / 360 
		circ_at_lat = Math.cos(self.lat * Math::PI / 180) * 24901.55
		lon_dist = (self.lon - lon) * circ_at_lat / 360
		return Math.sqrt(lat_dist**2 + lon_dist**2) 
	end

	def Convention.within(location, dist)
		loc = location.chomp
		loc = loc.tr(" ", "+")

		#Get info from google.
		json_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&sensor=true").read()
		data = JSON.parse(json_data)

		#Print the info.
		begin
			coord_lat = data['results'][0]['geometry']['location']['lat']
			coord_lon = data['results'][0]['geometry']['location']['lng']
		rescue NoMethodError
			return Convention.where(id: -1)
		end
		dist_array = []
		all_list.each do |d_l|
			if d_l.distance(coord_lat, coord_lon) <= dist
				dist_array += [d_l.id]
			end
		end
		#puts names_array
		return search_array(dist_array)

	end
	
end
