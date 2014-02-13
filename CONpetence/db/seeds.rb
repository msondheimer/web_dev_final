# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
all_convention_data = [ { :name => "Wizard World, Chicago Comic Con",
				 :genre => "Multi-genre",
				 :city => "Chicago, IL",
				 :venue => "Donald E. Stephens Convention Center",
				 :con_url => "http://www.wizardworld.com/home-ch.html",
				 :expected_size => 70000,
				 :start => "2014-08-21 00:00:00",
				 :end => "2014-08-24 00:00:00",
				 :logo_url => "http://www.ccsuvt.org/adl/wp-content/uploads/2013/11/Olympic-Rings.jpg" 
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
  c.logo_url = convention_info[:logo_url]
  c.save
end



