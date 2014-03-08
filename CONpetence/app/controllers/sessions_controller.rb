class SessionsController < ApplicationController

  def destroy
    reset_session
    redirect_to root_url, notice: "Goodbye."
  end


  def create
    email_address = params[:email]
    @user = User.find_by(email: email_address)
    
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_url, notice: "Welcome Back, #{@user.name}"
      else
        flash[:notice]="Invalid Password"
        render "new"
      end
    else
       flash  [:notice]="Unknown Email Address"
       render "new"
    end
  end

end
