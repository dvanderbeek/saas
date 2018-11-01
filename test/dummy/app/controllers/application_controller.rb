class ApplicationController < ActionController::Base
  before_action :configure_devise_params, if: :devise_controller?

  private

    def configure_devise_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name])
      # devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
    end
end
