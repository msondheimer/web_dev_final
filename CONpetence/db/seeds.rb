#<<<<<<< HEAD
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



all_convention_data = [ { :name => "Otakon",
				 :genre => "Anime",
				 :city => "Baltimore, MD",
				 :venue => "Baltimore Convention Center",
				 :con_url => "http://otakon.com",
				 :expected_size => 35000,
				 :start => "2013-08-09 09:00:00 EDT",
				 :end => "2013-08-11 16:00:00 EDT"
                },
                {
                	name: "Galifrey One",
                	genre: "Franchise Specific",
                	city: "Los Angeles, CA",
                	venue: "LAX Marriott",
                	con_url: "http://www.gallifreyone.com",
                	expected_size: 3200,
                	start: "2013-02-15 09:00:00 PST",
                	:end => "2013-02-17 19:00:00 PST"
                },
                {
                	name: "Gallfrey One",
                	genre: "Franchise Specific",
                	city: "Los Angeles, CA",
                	venue: "LAX Marriott",
                	con_url: "http://www.gallifreyone.com",
                	expected_size: 3200,
                	start: "2014-02-14 09:00:00 PST",
                	:end => "2014-02-16 19:00:00 PST"
                },
                {
                	name: "Anime Boston",
                	genre: "Anime",
                	city: "Boston, MA",
                	venue: "Hynes Convention Center",
                	con_url: "http://animeboston.com",
                	expected_size: nil,
                	start: "2014-03-21 09:00:00 EDT",
                	:end => "2014-03-23 16:00:00 EDT"
                }
            ]

Convention.destroy_all

all_convention_data.each do |convention_info|
  c = Convention.new
  c.name = convention_info[:name]
  c.genre = convention_info[:genre]
  c.city = convention_info[:city]
  c.venue = convention_info[:venue]
  c.con_url = convention_info[:con_url]
  c.expected_size = convention_info[:expected_size]
  c.start = convention_info[:start]
  c.end = convention_info[:end]
  c.save
end

otakon2013_photos = 
	["http://whatweekly.com/wp-content/uploads/2013/08/otakon_2013-28.jpg",
		"http://omonomono.com/wp-content/uploads/DSC02376.jpg",
		"http://www.baltimoresun.com/media/photo/2013-08/76943002.jpg",
		"http://media2.abc2news.com//photo/2013/08/11/Otakon_2013_825370000_20130811201734_640_480.JPG",
		"http://darkroom.baltimoresun.com/wp-content/uploads/2013/08/20130810_143756.jpg",
		"http://darkroom.baltimoresun.com/wp-content/uploads/2013/08/1.jpg",
		"http://www.geek.com/wp-content/uploads/2013/08/IMAG0186-590x333.jpg"
	]


Photo.destroy_all
c = Convention.find_by(name: "Otakon")
otakon2013_photos.each do |url|
	p = Photo.new
	p.photo_url = url
	p.con = c.id
	p.save
end



#=======

#>>>>>>> 0ffa41586da67fd40a7f14d2dde43f60b7fb1697
