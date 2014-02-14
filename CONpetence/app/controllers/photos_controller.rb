class PhotosController < ApplicationController

	def view_photo
		@photo = Photo.find_by(id: params[:photo_id])
		@con = Convention.find_by(id: @photo.con)
		if @photo == nil
			redirect_to "/conventions"
		else
			render 'photo'
		end
	end

end