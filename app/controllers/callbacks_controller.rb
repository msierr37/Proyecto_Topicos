class CallbacksController < Devise::OmniauthCallbacksController
  def google
      #raise request.env["omniauth.auth"].to_yaml
      @user = User.create_with_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user, event: :authentication
  end
end
