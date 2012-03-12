class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    render :text => request.env[omniauth.auth].to_yaml 
  end
  
  def google_oauth2
    render :text => request.env[omniauth.auth].to_yaml 
  
  end
  # def facebook
  #     @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
  #       if @user.save
  #         flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
  #         sign_in_and_redirect @user, :event => :authentication
  #       else
  #         # session["devise.facebook_data"] = @user
  #         redirect_to new_user_registration_path # (@user)
  #       end
  #   end



end