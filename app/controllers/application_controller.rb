class ApplicationController < ActionController::Base
  
  include Pundit
  #after_action :verify_authorized, except: [:index, :about]
  #after_action :verify_policy_scoped, only: :index
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_action :authenticate_user!
end
