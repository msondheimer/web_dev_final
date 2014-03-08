class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if not session[:user_id]
      redirect_to root_url, notice: "No way!"
    elsif session[:user_id] == params[:id]
      @editing = true
    elsif not @user
      redirect_to root_url  
    else
      @posted_photos = @user.posted_photos
      @photos_in = @user.photos
      render 'profile'
    end
  end

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
