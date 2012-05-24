module LayoutsHelper
  
  def show_auths
    show_hash = {}
    if current_user
      show_hash[:fb] = current_user.authentications.where(:provider => "facebook").empty? ? true : false
      show_hash[:twit] = current_user.authentications.where(:provider => "twitter").empty? ? true : false
      show_hash[:goo] = current_user.authentications.where(:provider => "google_oauth2").empty? ? true : true
      show_hash[:show_any] = current_user.authentications.count == 3 ? false : true
    end
    show_hash
  end
  
  
end