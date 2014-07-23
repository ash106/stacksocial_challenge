class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:session][:email], params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.email}!"
      redirect_to session[:intended_url] || root_path
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
