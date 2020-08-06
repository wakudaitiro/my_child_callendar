class ApplicationController < ActionController::Base
  protect_from_forgery except: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[babyname username memo sex])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[babyname username memo sex])
  end
end
