require 'open-uri'
require 'json'

class Convention < ActiveRecord::Base

	validates_presence_of :name, message: "You need to enter a convention name."
	validates_presence_of :genre, message: "Need to specify genre"
	validates_presence_of :lat, message: "Need to specify a location"
	#validates_presence_of :lon, message: "Need to specify state"
	validate :start_before_end, :reasonable_time_span
	validate :not_a_repeat

	def start_before_end
		r = false
		begin
			r = self.start <= self.end
		rescue NoMethodError
			r = false
		end
		if not r
			errors.add(:end, "Must be after start")
		end
	end

	def reasonable_time_span
		r = false
		begin 
			r = self.end.to_date.mjd - self.start.to_date.mjd < 7
		rescue NoMethodError
			r = false
		end
		if not r
			errors.add(:end, "Con can't be over a week long")
		end
	end

	def not_a_repeat
		r = false
		there = 0
		if self.id
			there = 1
		end
		start = self.start - 2.days
		fin = self.end + 2.days
		date_hash = {}
		[start, fin].each do |d|
			date_hash[d] = "#{d.year}-#{d.month}-#{d.day}"
		end
		r = Convention.before(date_hash[fin]).after(date_hash[start]).search_name(self.name).within(self.address, 20).count == there
		if not r
			errors.add(:name, "This con seems like a repeat")
		end
	end

	before_validation :find_coords

	has_many :photos, dependent: :destroy

	def address
		address = ""
		if self.city
			address = self.city.chomp
		else
			return ""
		end
		if self.venue
			address += "+#{self.venue.chomp}"
		end
		return address.tr(" ", "+")
	end

	def find_coords
		if self.city == nil
			self.lat = nil
			self.lon = nil
		else
			address = self.address #address.tr(" ", "+")
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
		return Convention.genres.zip(Convention.genres)
	end

	

	scope :future, -> {where("end >= ?", Time.now).order("start asc")}

	#scope :past, -> {where("start <= ?", Time.now).order("start desc")}
	scope :past, -> {where("start <= ?", Time.now).order("start asc")}

	scope :present, ->{future.past} 

	#scope :from, ->(duration){ where('start > ?', Time.zone.today - duration ).order("start asc") }


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
		z = pluck(:id, :name).map {|i,n| n.downcase.gsub(/\W+/, '').include?(mod_string) ? i : -1}
		where(id: z)
	end

	scope :search_array, -> (arr) {where(id: arr)}

	scope :after, -> (date) {where("end >= ?", Date::strptime(date, "%Y-%m-%d")).order("start asc")}

	scope :before, -> (date) {where("start <= ?", Date::strptime(date, "%Y-%m-%d")).order("start asc")}

	def Convention.next(name) 
		future.find_by(name: name)
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
		all.each do |d_l|
			if d_l.distance(coord_lat, coord_lon) <= dist
				dist_array += [d_l.id]
			end
		end
		#puts names_array
		return search_array(dist_array)

	end

	def find_year
		if self.start.year != self.end.year
			return "#{self.start.year}-#{self.end.year}"
		else
			return "#{self.start.year}"
		end
	end
	
end
