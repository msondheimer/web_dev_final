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

end