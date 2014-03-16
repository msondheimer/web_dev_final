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
				 :expected_size => [29337, 30785, 34211, 37000],
				 :start => ['2011-07-29', '2012-07-27', '2013-08-09', '2014-08-08'],
				 :length => 3
                },

                {name: "Gallifrey One",
                  genre: "Specific Franchise",
                  city: "Los Angeles, CA",
                  venue: "LAX Marriott",
                  con_url: "http://www.gallifreyone.com",
                  expected_size: [2500, 2500, 3200, 3200],
                  start: ['2011-02-18', '2012-02-17', '2013-02-15', '2014-02-14'],
                  length: 3},

                {name: "Anime Boston",
                  genre: "Anime",
                  city: "Boston, MA",
                  venue: "Hynes Convention Center",
                  con_url: "http://www.animeboston.com/‎",
                  expected_size: [19136, 22065, 21825, 22000],
                  start: ['2011-04-22', '2012-04-06', '2013-05-24', '2014-03-21'],
                  length: 3},

                {name: "San Diego Comic-Con International",
                  genre: "Multigenre",
                  city: "San Diego, CA",
                  venue: "San Diego Convention Center",
                  con_url: "http://www.comic-con.org/",
                  expected_size: [126000, 130000, 150000, 150000],
                  start: ['2011-07-21', '2012-07-12', '2013-07-18', '2014-07-24'],
                  length: 4},

                {name: "GenCon",
                  genre: "Gaming",
                  venue: "Indiana Convention Center",
                  city: "Indianapolis, IN",
                  con_url: "http://www.gencon.com",
                  expected_size: [36733, 41000, 49058, 50000],
                  start: ['2011-08-04', '2012-08-16', '2013-08-15', '2014-08-14'],
                  length: 4},

                {name: "Emerald City Comicon",
                  genre: "Comics",
                  city: "Seattle, WA",
                  venue: "Washington State Convention Center",
                  con_url: "http://www.emeraldcitycomicon.com/",
                  expected_size: [32000, 53000, 64000, 70000],
                  start: ['2011-03-04', '2012-03-30', '2013-03-01', '2014-03-28'],
                  length: 3},

                {name: "Capricon",
                  genre: "Sci-Fi",
                  city: "Wheeling, IL",
                  venue: "Westin Chicago North Shore",
                  con_url: "http://capricon.org/",
                  expected_size: [nil, nil, nil, nil],
                  start: ['2011-02-10', '2012-02-09', '2013-02-07', '2014-02-06'],
                  length: 4},

                {name: "Mad Monster Party",
                  genre: "Horror",
                  city: "Charlotte, NC",
                  venue: "Hilton Charlotte University Place",
                  con_url: "http://www.themadmonsterparty.com/",
                  expected_size: [nil],
                  start: ['2014-03-21'],
                  length: 3},

                {name: "Gaslight Gathering",
                  genre: "Steampunk",
                  city: "San Diego, CA",
                  venue: "Town and Country Hotel",
                  con_url: "http://gaslightgathering.org/",
                  expected_size: [nil],
                  start: ['2014-05-02'],
                  length: 3}  


            ]

all_character_names = ["Amy Pond", "Rory William", "Eleventh Doctor", "Tenth Doctor", "Ninth Doctor", "Fourth Doctor", "K-9", "Wanda", "Cosmo", "Thor", "Hulk", "Doug", "Quailman", "Harley Quinn", "Joker", "Poison Ivy", "Jaime Lannister", "Cersei Lannister", "Arya Stark"]

Photo.destroy_all
Convention.destroy_all
Character.destroy_all
#Can't seed local photo files to heroku, sorry.

all_convention_data.each do |convention_info|
  convention_info[:expected_size].zip(convention_info[:start]).each do |size, start, photos|
    c = Convention.new
    c.name = convention_info[:name]
    c.genre = convention_info[:genre]
    c.city = convention_info[:city]
    c.venue = convention_info[:venue]
    c.con_url = convention_info[:con_url]
    c.expected_size = size
    c.start = start
    c.end_date = Date.parse(start.to_s) + convention_info[:length] - 1
    c.find_coords
    c.save(validate: false)
    venue = c.venue
    while c.lat == nil
      c.venue = nil
      c.find_coords
      c.venue = venue
      c.save(validate: false)
    end
  end
end

all_character_names.each do |n|
  c = Character.new
  c.name = n
  c.cosplaying = "Nothing here yet"
  c.save
end








#=======

#>>>>>>> 0ffa41586da67fd40a7f14d2dde43f60b7fb1697
