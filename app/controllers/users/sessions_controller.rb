class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  helper SessionsHelper
  after_action :set_login_time_zone, only: [:create]



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

    # set time zone for current session
    def set_login_time_zone
      session[:login_time_zone] = view_context.time_zone_from_ip(current_user.current_sign_in_ip)
    end
end
