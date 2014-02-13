class ConventionsController < ApplicationController

	def browse_cons
		@cons = Convention.all.order("start asc")
		render 'conventions'
	end

	def show
		@con = Convention.find_by(:id => params[:con_id])
		render 'show'
	end

	def browse_photos
		@con = Convention.find_by(:id => params[:con_id])
		#If someone tries to see photos for a future con, that shouldn't be allowable.
		if @con.start > Time.now
			redirect_to "/conventions"
		else
			@photos = Photo.where(:con => params[:con_id])
			render 'photos'
		end
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