class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      flash[:alert] = "Please log in."
      redirect_to login_path
    end
  end
end
