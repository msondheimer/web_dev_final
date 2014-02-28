class PhotosController < ApplicationController

	def tag_char
		cht = CharTag.new
		cht.character_id = params[:character_id]
		cht.photo_id = params[:photo_id]
		cht.save
		redirect_to "/photos/#{params[:photo_id]}"
	end

	def view_photo
		@photo = Photo.find_by(id: params[:photo_id])
		if @photo == nil
			redirect_to "/conventions"
		else
			@con = @photo.convention
			@characters = @photo.characters
			@users = @photo.users
			if 
			render 'photo'
		end
	end

	def toast_char
		CharTag.find_by(id: params[:chartag]).destroy
		redirect_to "/photos/#{params[:photo_id]}"
	end

	def redir_to_cons
		redirect_to "/conventions"
	end

end