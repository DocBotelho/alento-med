class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Added to authenticate user before any action and protect every route
  before_action :authenticate_user!
  # Added to permit insert more info on sign up
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :location])
  end
end
