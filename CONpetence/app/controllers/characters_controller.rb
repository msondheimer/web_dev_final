class CharactersController < ApplicationController
	def new
		render 'new'
	end

	def create
		character = Character.new
		character.name = params[:name]
		character.cosplaying = params[:cosplaying]
		character.save
		redirect_to "/characters"
	end

	def index
		@chars = Character.all.order("name asc")
		render 'index'
	end

	def show
		@char = Character.find_by(id: params[:id])
		@photos = @char.photos
		render 'show'
	end

	def update
		@char = Character.find_by(id: params[:id])
		@char.cosplaying = params[:costume]
		@char.save
		redirect_to "/characters/#{params[:id]}"
	end

	def edit
		@char = Character.find_by(id: params[:id])
		render 'edit'
	end



end