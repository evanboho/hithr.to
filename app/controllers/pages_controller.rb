class PagesController < ApplicationController
    
  def home
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about
  end

  def contact
    @user = current_user
    @user = User.first #User.where(:firstname => "admin").first
    @message = Message.new
  end
  
  def send_contact
    MessageMailer.send_contact(params).deliver
    redirect_to root_path
  end

  def help
  end
end
