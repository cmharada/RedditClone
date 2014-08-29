class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def logout!
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
  end
end
