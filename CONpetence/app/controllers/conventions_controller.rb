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


	def add_photo
		@con_id = params[:con_id]
		#@con = Convention.find_by(:id => params[:con_id])
		render 'new_photo'
	end

	def new_photo
		#@con = Convention.find_by(:id => params[:con_id])
		@the_con_id = params["con_id"]
		p = Photo.new
		p.photo_url = params["image_url"]
		p.con = @the_con_id
		p.save
		redirect_to "/conventions/#{@the_con_id}/photos"
	end
end