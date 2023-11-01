class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def log_in(user)
      session[:user_id] = user.id
    end
    
    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user  # Log in the user after registration
        redirect_to root_url, notice: 'Welcome to your app!'
      else
        render 'new'
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
  
