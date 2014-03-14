class CharactersController < ApplicationController
	before_action :require_login, :except => [:index, :show]

	def require_login
      if session[:user_id].blank?
        redirect_to "/characters", notice: "Sign in to do that!"
      end
    end

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