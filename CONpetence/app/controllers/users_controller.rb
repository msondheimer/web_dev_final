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

  def new_user_form
    @user = User.new
    render 'new_user'
  end


  def create
    @user = User.new
    @user.name = params["user"]["name"]
    @user.email = params["user"]["email"]
    @user.password = params["user"]["password"]
    @user.password_confirmation = params["user"]["password_confirmation"]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      render 'new_user'
    end
  end
end
