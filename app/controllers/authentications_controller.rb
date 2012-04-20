class AuthenticationsController < ApplicationController
 
  def index
    @authentications = current_user if current_user
  end

  def show
    @authentication = Authentication.find(params[:id])
  end
    
  def new
    @authentication = Authentication.new
  end
  
  def failure
    render :text => request.env['omniauth.auth'].to_yaml
  end
    

  def create
    info = request.env['omniauth.auth'].extra.raw_info
    auth = request.env['omniauth.auth'].except('extra')
    # render :text => auth['info']
     authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
     if authentication
       flash[:notice] = "signed in!"
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       authentication = Authentication.new
       current_user.authentications.create!(:provider => auth.provider, :uid => auth.uid, :nickname => auth['info'].nickname)
       flash[:notice] = "connected!"
       current_user.profile.cred += 1
       current_user.profile.save
       redirect_to current_user
     elsif user = User.find_by_email(auth['info'].email)
       user.authentications.create!(:provider => auth.provider, :uid => auth.uid)
       flash[:notice] = "found and connected!"
       user.profile.cred += 1
       user.profile.save
       sign_in_and_redirect(:user, user)
     # 
     # elsif user = User.find_by_firstname_and_lastname(auth['info'].name.split.first, auth['info'].name.split.last)
     #   user.build_auth(auth)
     #   flash[:notice] = "connected and signed in!"
     #   user.profile.cred += 1
     #   user.profile.save
     #   sign_in_and_redirect(:user, user)
     #
     else
       user = User.new(:firstname => auth['info'].name.split.first, :lastname => auth['info'].name.split.last, 
                       :email => auth['info'].email, :password => Devise.friendly_token[0,20])
       if user.save
          user.build_auth(auth)
          flash[:notice] = "created, connected and signed in!"
          user.profile.cred += 1
          user.profile.save
          sign_in_and_redirect(:user, user)
        else
          flash[:warning] = "Sorry! You can't create an account with Twitter."
          # session['devise.omniauth'] = auth
          redirect_to sign_up_path
        end
     end
  end

 
  def destroy
    @authentication = current_user.find(params[:id])
    @authentication.destroy
    flash[:notice] = "success"
    redirec_to current_user
  end
  
end
