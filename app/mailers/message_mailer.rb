class MessageMailer < ActionMailer::Base
  default from: "unnaive@gmail.com"
  
  def send_message(message)
    @msg = message
    mail(:to => message.user.email, :subject => "hithr.to: Message from #{message.sender.username}. Re: #{ message.sujet}")
  end
  
end
