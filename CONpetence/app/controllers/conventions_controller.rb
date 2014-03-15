#make it so lat lon error doesnt show up on search
#change homepage to show only next 10 and past 3 cons
class ConventionsController < ApplicationController

	before_action :require_login, :only => [:create, :new_con_form, :add_photo, :new_photo]

	@search = false 

    def require_login
      if session[:user_id].blank?
        redirect_to root_url, notice: "Nice Try!"
      end
    end

	def browse_cons
		@genre_name = 'All'
		@cons = Convention.home
		render 'conventions'
	end


	def future_conventions
		@cons = Convention.future
		render 'conventions'
	end

	def past_conventions
		@cons = Convention.past
		render 'conventions'
	end

	def search_results
		@search = true
		@message = "Showing #{params[:genre]} conventions"
		if params[:name] != ""
			@message +=  " whose names contain #{params[:name]}"
		end
		if params[:loc] == "" or params[:dist] == ""
			params[:loc] = "Chicago, IL"
			params[:dist] = 1000000
		else
			@message += " within #{params[:dist]} miles of #{params[:loc]}"
		end
		@message += " between #{params[:after][:month]}/#{params[:after][:day]}/#{params[:after][:year]} 
				and #{params[:before][:month]}/#{params[:before][:day]}/#{params[:before][:year]}"
		@cons = Convention.genre(params[:genre]).before("#{params[:before][:year]}-#{params[:before][:month]}-#{params[:before][:day]}")
				.after("#{params[:after][:year]}-#{params[:after][:month]}-#{params[:after][:day]}")
				.search_name(params[:name]).within(params[:loc], params[:dist].to_f)
		render 'conventions'
	end

	def filter
		@genre_name = params[:genre]
		@cons = Convention.home(@genre_name).has_time.order("start asc")
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

	def new_con_form
		@con = Convention.new
		render 'new_con'
	end

	def create
		@con = Convention.new
		@con.name = params["convention"]["name"]
		@con.genre = params['convention']['genre']
		@con.city = params['convention']['city']
		@con.venue = params['convention']['venue']
		@con.expected_size = params['convention']['expected_size']
		@con.con_url = params["convention"]["con_url"]
		@con.start = "#{params['convention']['start(1i)']}-#{params['convention']['start(2i)']}-#{params['convention']['start(3i)']}"
		@con.end_date = "#{params['convention']['end_date(1i)']}-#{params['convention']['end_date(2i)']}-#{params['convention']['end_date(3i)']}"
		@con.description = params['convention']['description']
		if @con.save
			redirect_to '/conventions'
		else
			render 'new_con'
		end
	end


	private
	def user_params
		params.require(:photo).permit(:picture)
	end
end