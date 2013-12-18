class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_user!


  private

  def require_user!
    unless current_user
      flash[:error] = 'Please login to proceed.'
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

end
