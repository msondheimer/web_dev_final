class PhotosController < ApplicationController

	def addchar
		cht = CharTag.new
		cht.character_id = params[:character_id]
		cht.photo_id = params[:photo_id]
		cht.save
		redirect_to "/photos/#{params[:photo_id]}"
	end

	def show
		@photo = Photo.find_by(id: params[:photo_id])
		if @photo == nil
			redirect_to "/conventions/#{@con_id}/photos"
		else
			@con = @photo.convention
			@characters = @photo.characters.order("name asc")
			@users = @photo.users
			@guest = true
			@posting_user = User.find_by(id: @photo.posting_user)
			if session[:user_id]
				@guest = false
				if @photo.in_photo?(session[:user_id])
					@link = "/photos/#{@photo.id}/untagme"
					@method = :delete
					@text = "Untag Me"
				else
					@link = "/photos/#{@photo.id}/tagme"
					@method = :post
					@text = "Tag Me"
				end
			end
			render 'photo'
		end
	end

	def toast_char
		CharTag.find_by(id: params[:chartag]).destroy
		redirect_to "/photos/#{params[:photo_id]}"
	end

	def toast_photo
		p = Photo.find_by(id: params[:photo_id])
		if session[:user_id] == p.posting_user
			@con_id = p.convention_id
			p.destroy
			redirect_to "/conventions/#{@con_id}/photos"
		else
			redirect_to "/photos/#{p.id}", notice: "You can't do that!"
		end
	end

	def toast_user
		if UserTag.find_by(photo_id: params[:photo_id], user_id: session[:user_id])
			UserTag.find_by(photo_id: params[:photo_id], user_id: session[:user_id]).destroy
		end
		redirect_to "/photos/#{params[:photo_id]}"
	end

	def tag_user
		if not UserTag.find_by(photo_id: params[:photo_id], user_id: session[:user_id])
			ut = UserTag.new
			ut.photo_id = params[:photo_id]
			ut.user_id = session[:user_id]
			ut.save
		end
		redirect_to "/photos/#{params[:photo_id]}"
	end

	# def redir_to_cons
	# 	redirect_to "/conventions"
	# end

end