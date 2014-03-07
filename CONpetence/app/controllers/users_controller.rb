class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      redirect_to root_url, notice: "No way!"
    end
  end

  def create
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      render 'new'
    end
  end
end

# class UsersController < ApplicationController
#   def new
#     @user = User.new
#   end
#   def create
#     @user = User.new(params[:user])
#     if @user.save
#       flash[:notice] = "You signed up successfully"
#       flash[:color]= "valid"
#     else
#       flash[:notice] = "Form is invalid"
#       flash[:color]= "invalid"
#     end
#     render "new"
#   end
# end
