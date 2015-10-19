require 'target_process'
require 'pry'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_session
    redirect_to new_session_path and return unless valid_session?
  end

  def valid_session?
    return false if session[:target_process_login].nil?
    return false if session[:target_process_password].nil?
    return false if session[:target_process_url].nil?
    true
  end
end
