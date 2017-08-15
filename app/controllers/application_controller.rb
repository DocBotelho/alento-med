class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Added to authenticate user before any action and protect every route
  before_action :authenticate_user!
end
