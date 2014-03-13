class UsersController < ApplicationController

  def show
    flash[:notice] = nil
    @user = User.find(params[:id])
    if not session[:user_id]
      redirect_to root_url#, notice: "No way!"
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

  def edit
    @user = User.find(params[:id])
    render 'edit'
  end

  def new_user_form
    @user = User.new
    render 'new_user'
  end

 def destroy
    session[:user_id] = nil
    u = User.find_by(params[:id])
    u.destroy
    redirect_to root_url
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      #@user = User.find(params[:id])
      #flash[:notice]="#{@name} has been taken, try again"
      render 'edit'
    end 
  end
  


  def create
    @user = User.new
    @user.name = params["user"]["name"]
    @user.email = params["user"]["email"]
    @user.password = params["user"]["password"]
    @user.password_confirmation = params["user"]["password_confirmation"]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url#, notice: "Thanks for signing up!"
    else
      render 'new_user'
    end
  end
end
