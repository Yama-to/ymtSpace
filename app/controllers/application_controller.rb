class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # devise parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # add permitted flash messages
  add_flash_types :success, :info, :warning, :danger

  # devise redirect paths after actions
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :position, :occupation, :profile, :avatar)
    devise_parameter_sanitizer.for(:account_update).push(:name, :position, :occupation, :profile, :avatar)
  end
end
