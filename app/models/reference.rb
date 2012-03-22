class Reference < ActiveRecord::Base

  belongs_to :user
  
  attr_accessible :content, :positive
  
  validates :user_id, :presence => true
  validates :sender_id, :presence => true
  validates :positive, :presence => true
  

  def msg_time
    t = created_at.strftime("%b %d, %l:%M")
    t = t + ' am' if created_at.hour < 12
    t = t + ' pm' if created_at.hour > 12
    t
  end

  def sender
    u = User.where(:id => sender_id)
    if u.present?
      return u.first
    else
      nil
    end
  end
  
  def positive_exp?
    return "super!"       if positive == 2
    return "pretty good!" if positive == 1
    return "negative"     if positive == -2
    return "sort of awk"  if positive == -1
    return "just OK"           if positive == 0
  end

end