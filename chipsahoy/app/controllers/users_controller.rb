class UsersController < ApplicationController

  def create
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save
    session[:user_id] = user.id
    redirect_to root_url, notice: "Thanks for signing up!"
  end
end
