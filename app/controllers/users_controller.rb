class UsersController < ApplicationController
  inherit_resources

  def create
    create! { users_path }
  end

  def update
    update! { users_path }
  end

  def add_oauth
    current_user.add_oauth(env["omniauth.auth"])
    redirect_to users_path
  end


  private

  def permitted_params
    params.permit(:user => [:name, :email, :password, :password_confirmation])
  end

end