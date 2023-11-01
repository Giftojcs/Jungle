class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user  # Log in the user
      redirect_to root_url, notice: 'Logged in successfully!'
    
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end

    def destroy
      log_out  # Log out the user
      redirect_to root_url, notice: 'Logged out successfully!'
    end
  end
  end
