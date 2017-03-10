class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # If the user is submitting a form from the devise controller,
  # then run the configure_permitted_parameters action, which
  # whitelists which fields we're willing to permit to enter our website
  # so someone can't add their own
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    end
end
