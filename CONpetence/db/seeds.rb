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
