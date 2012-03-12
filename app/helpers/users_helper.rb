module UsersHelper
  
  def twitter_link
    "http://www.twitter.com/" + @user.authentications.where(:provider => "twitter").first.nickname
  end
  
  def facebook_link
    "http://www.facebook.com/" + @user.authentications.where(:provider => "facebook").first.uid
  end
  
  def google_link
    "http://www.google.com"
  end
  
  def auth_link(auth)
    return "http://www.twitter.com/" + @user.authentications.where(:provider => "twitter").first.nickname if auth.provider == "twitter"
    return "http://www.facebook.com/" + @user.authentications.where(:provider => "facebook").first.uid if auth.provider == "facebook"
    return "" if auth.provider == "google_oauth2"
  end

  def cred_magic(cred)
    cred ||= 0
    cred += 1 if @user.profile.avatar_file_name.present?
    if @user.profile.about.present?
      cred += 1 if @user.profile.about.length > 20
    end
    cred += 1 if @user.profile.hometown.present?
    cred += @user.authentications.count
  end

end