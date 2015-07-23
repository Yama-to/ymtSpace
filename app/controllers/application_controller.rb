class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # devise parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise redirect paths after actions
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :participation, :occupation, :profile, :avatar)
  end
end
