class PhotosController < ApplicationController

	def view_photo
		@photo = Photo.find_by(id: params[:photo_id])
		if @photo == nil
			redirect_to "/conventions"
		else
			@con = Convention.find_by(id: @photo.con)
			render 'photo'
		end
	end

	def redir_to_cons
		redirect_to "/conventions"
	end

end