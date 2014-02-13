class ConventionsController < ApplicationController

	def browse_cons
		@cons = Convention.all.order("start asc")
		render 'conventions'
	end

	def show
		@con = Convention.find_by(:id => params[:con_id])
		render 'show'
	end

end