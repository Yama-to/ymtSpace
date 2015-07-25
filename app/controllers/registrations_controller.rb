class RegistrationsController < Devise::RegistrationsController
  # devise redirect paths after actions
  def after_inactive_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end


end
