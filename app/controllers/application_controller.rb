class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def after_sign_in_path_for(user)
    if !current_user.mech_status
     "/cars"
    else
      "/mechanics"
    end
  end

  def after_sign_up_path_for(resource)
    if !current_user.mech_status
     "/cars"
    else
      "/mechanics"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :zip_code, :mech_status, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:email, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:account_update){|u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :remember_me)}
  end
end

