class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  def current_user
    #return this user if session's user_id exists in browser session hash
    #if user is already logged in
    @currenter_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #returns true if current_user is logged in
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
end
