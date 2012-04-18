class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def handle_unverified_request
    true
  end
  
  def current_user?
     if !current_user
       flash[:error] = "you must be signed in to do that."
       redirect_to sign_in_path
     end
   end
   
   private 
  
   def mobile_device?
     request.user_agent =~ /Mobile|webOS/
   end
   
   def admin
     User.find(2)
   end
   
   helper_method :mobile_device?
   helper_method :admin
end
