class PhotosController < ApplicationController

	def index
		@photos = Photo.all
	end

	def new
		@photo = Photo.new
	end


	def create
	  @photo = Photo.create( user_params )
	  redirect_to root_url
	end

	private
	def user_params
		params.require(:photo).permit(:name, :picture)
	end


end