class ConventionsController < ApplicationController

	before_action :require_login, :only => [:create, :new_con_form, :add_photo, :new_photo]
 

    def require_login
      if session[:user_id].blank?
        redirect_to root_url, notice: "Nice Try!"
      end
    end

	def browse_cons
		@genre_name = 'All'
		@cons = Convention.all.has_time.order("start asc")
		render 'conventions'
	end

	def filter
		@genre_name = params[:genre]
		@cons = Convention.genre(@genre_name).has_time.order("start asc")
		render 'conventions'
	end

	def show
		#***nil is not working!***
		@con = Convention.find_by(:id => params[:con_id])
		if @con == nil
			redirect_to "/conventions"
		else
			render 'show'
		end
	end

	def browse_photos
		@con = Convention.find_by(:id => params[:con_id])
		#If someone tries to see photos for a future con, that shouldn't be allowable.
		if @con.start > Time.now
			redirect_to "/conventions"
		else
			@photos = @con.photos
			render 'photos'
		end
	end

	def add_photo
		@con_id = params[:con_id]
		@photo = Photo.new
		#@con = Convention.find_by(:id => params[:con_id])
		render 'new_photo'
	end

	def new_photo
		#@con = Convention.find_by(:id => params[:con_id])
		@the_con_id = params["con_id"]
	  	@photo = Photo.create( user_params )
	  	@photo.convention_id = @the_con_id
	  	@photo.posting_user = session[:user_id]
	  	@photo.save
	  	redirect_to "/conventions/#{@the_con_id}/photos"
	end

	private
	def user_params
		params.require(:photo).permit(:picture)
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