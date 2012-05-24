class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def handle_unverified_request
    true
  end
  
  def local_request?
    if admin?
      true
    else
      false
    end
  end
  
  def current_user?
     if !current_user
       flash[:error] = "you must be signed in to do that."
       store_location
       redirect_to sign_in_path
     end
   end
   
  def after_sign_in_path_for(resource)
    session[:return_to] || root_path
    session.delete(:return_to)
  end
   
   private 
  
   def mobile_device?
     request.user_agent =~ /Mobile|webOS/
   end
   
   def admin
     User.where(:email => "hithr.to@gmail.com").first
   end
   
   def admin?
     current_user == admin
   end 
   
   def store_location
     session[:return_to] = request.fullpath
   end
   
   helper_method :admin?
   helper_method :mobile_device?
   helper_method :admin
end
