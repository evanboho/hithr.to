module RegistrationsHelper
  
  def sender
    u = User.where(:id => sender_id)
    if u.present?
      return u.first
    else
      nil
    end
  end
  
end
