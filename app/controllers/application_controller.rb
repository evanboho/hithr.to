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
       redirect_to sign_in_path
     end
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
   
   helper_method :admin?
   helper_method :mobile_device?
   helper_method :admin
end
