class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  private
  
  def require_user_loggled_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
