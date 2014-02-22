class ConventionsController < ApplicationController

	def browse_cons
		@genre_name = 'All'
		@cons = Convention.all.has_time.order("start asc")
		render 'conventions'
	end

	# def filter
	# 	@cons = Convention.genre(params[:genre]).has_time.order("start asc")
	# 	render 'conventions'
	# end


	def filter
		#@cons = Convention.find_by(:genre => params[:genre])
		@genre_name = params[:genre]
		@cons = Convention.genre(@genre_name).has_time.order("start asc")

		render 'conventions'
	end

	def show
		#***nil is not working!***
		@con = Convention.find_by(:id => params[:con_id])
		if @con == nil
			redirect_to "/conventions"
		end
		render 'show'
	end

	def browse_photos
		@con = Convention.find_by(:id => params[:con_id])
		#If someone tries to see photos for a future con, that shouldn't be allowable.
		if @con.start > Time.now
			redirect_to "/conventions"
		else
			@photos = @con.photos
			render 'photos'
		end
	end

	def add_photo
		@con_id = params[:con_id]
		#@con = Convention.find_by(:id => params[:con_id])
		render 'temp'
	end

	def new_photo
		#@con = Convention.find_by(:id => params[:con_id])
		@the_con_id = params["con_id"]
		p = Photo.new
		p.photo_url = params["image_url"]
		p.convention_id = @the_con_id
		p.save
		redirect_to "/conventions/#{@the_con_id}/photos"
	end

	def new_con_form
		@con = Convention.new
		render 'new_con'
	end

	def create
		c = Convention.new
		c.name = params["convention"]["name"]
		c.genre = params['convention']['genre']
		c.city = params['convention']['city']
		c.venue = params['convention']['venue']
		c.expected_size = params['convention']['expected_size']
		c.con_url = params["convention"]["con_url"]
		c.start = params['convention']['start']
		c.end = params['convention']['end']
		c.save
		redirect_to '/conventions'
	end

end