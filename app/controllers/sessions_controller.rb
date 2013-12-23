class SessionsController < ApplicationController

  skip_before_filter :require_user!

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = 'Logged in.'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid credentials.'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end