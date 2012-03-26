class MessageMailer < ActionMailer::Base
  default from: "unnaive@gmail.com"
  
  def send_message(message)
    @msg = message
    mail(:to => message.user.email, :subject => "hithr.to: Message from #{message.sender.username} - #{message.sujet}")
  end
  
  def reference_notifier(reference)
    @ref = reference 
    mail(:to => reference.user.email, :subject => "hithr.to: #{reference.sender.username} left you a reference!")
  end
  
  
end
