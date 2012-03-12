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
    auth = request.env['omniauth.auth'].except('extra')  #.extra.raw_info
    # render :text => auth['info']
    info = request.env['omniauth.auth'].extra.raw_info
     authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
     if authentication
       flash[:notice] = "found already existing auth"
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       authentication = Authentication.new
       current_user.authentications.create!(:provider => auth.provider, :uid => auth.uid, :nickname => auth['info'].nickname)
       flash[:notice] = "added auth to current user"
       current_user.profile.cred += 1
       current_user.profile.save
       redirect_to current_user
     elsif user = User.find_by_email(auth['info'].email)
       user.authentications.create!(:provider => auth.provider, :uid => auth.uid)
       flash[:notice] = "found user from email and created auth"
       user.profile.cred += 1
       user.profile.save
       sign_in_and_redirect(:user, user)
     elsif user = User.find_by_firstname_and_lastname(auth['info'].name.split.first, auth['info'].name.split.last)
       user.build_auth(auth)
       flash[:notice] = "found user from name and created authentication"
       user.profile.cred += 1
       user.profile.save
       sign_in_and_redirect(:user, user)
     else
       user = User.new(:firstname => auth['info'].name.split.first, :lastname => auth['info'].name.split.last, 
                       :email => auth['info'].email, :password => Devise.friendly_token[0,20])
       if user.save
          user.build_auth(auth)
          flash[:notice] = "created user and authentication"
          user.profile.cred += 1
          user.profile.save
          sign_in_and_redirect(:user, user)
        else
          flash[:notice] = "no success"
          session['devise.omniauth'] = auth
          redirect_to user_edit_fields_path
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
