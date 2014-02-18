#<<<<<<< HEAD
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'date'

all_convention_data = [ { :name => "Otakon",
				 :genre => "Anime",
				 :city => "Baltimore, MD",
				 :venue => "Baltimore Convention Center",
				 :con_url => "http://otakon.com",
				 :expected_size => [29337, 30785, 34211, 35000],
				 :start => ['2011-07-29','2012-07-27',"2013-08-09", '2014-08-08'],
         :end => 3

         }
         {
          name: "Gallifrey One"
          city: "Los Angeles, CA"
         }
            ]

Convention.destroy_all

all_convention_data.each do |convention_info|
  convention_info[:expected_size].zip(convention_info[:start]).each do |con_size, con_start|
    c = Convention.new
    c.name = convention_info[:name]
    c.genre = convention_info[:genre]
    c.city = convention_info[:city]
    c.venue = convention_info[:venue]
    c.con_url = convention_info[:con_url]
    c.expected_size = con_size
    c.start = con_start
    c.end = Date.parse(con_start.to_s) + convention_info[:end] - 1
    c.save
  end
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


# Photo.destroy_all
# c = Convention.find_by(name: "Otakon", :start.year => 2013)
# otakon2013_photos.each do |url|
# 	p = Photo.new
# 	p.photo_url = url
# 	p.con = c.id
# 	p.save
# end



#=======

#>>>>>>> 0ffa41586da67fd40a7f14d2dde43f60b7fb1697
