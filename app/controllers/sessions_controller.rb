class SessionsController < ApplicationController

  # def new
  #   @user = User.new
  # end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in."
      redirect_to user_path(user)
    else
      flash[:errors] = "Unauthorized. Go away Rebecca."
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
