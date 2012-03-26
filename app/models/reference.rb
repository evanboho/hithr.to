class Reference < ActiveRecord::Base

  belongs_to :user
  
  attr_accessible :content, :positive
  
  validates_presence_of :user_id, :sender_id, :positive, :content
  

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
  
  def line_breaks
    content.split("\n")
  end
  
  def positive_exp?
    return "super!"       if positive == 2
    return "fine and dandy" if positive == 1
    return "negative"     if positive == -2
    return "sort of awk"  if positive == -1
    return "just OK"           if positive == 0
  end
  
  def self.positive_refs
    ref = self.scoped
    ref.where('positive > ?', 0)
  end
  def self.neutral_refs
    self.where(:positive => 0)
  end
  def self.negative_refs
    self.where('positive < ?', 0)
  end

end