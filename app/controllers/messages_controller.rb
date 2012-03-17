class MessagesController < ApplicationController

  before_filter :current_user?

  def index
    @messages = current_user.messages.order('created_at DESC')
    @messages_sent = Message.sent(current_user)
    #msg = current_user.messages.last
    #redirect_to message_path(msg)
  end
  
  def show
    @message = Message.find(params[:id])
    @messages = current_user.messages.order('created_at DESC')
    @messages_sent = Message.sent(current_user)
    @reply = current_user.messages.new
  end
  
  def reply
    @reply = current_user.messages.new
  end
  
  def new
    @user = User.find(params[:user_id])
    @message = @user.messages.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.build(params[:message])
    @message.sender_id = current_user.id
    @message.read = false
    if @message.save
      flash[:notice] = "Message sent"
      redirect_to @message
    else
      render 'new'
    end
  end
  
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = "message updated"
      redirect_to user_messages_path(current_user)
    else
      flash[:error] = "what happened?"
      render 'edit'
    end
  end
  
  def edit
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
  end
  
  def destroy
    Message.find(params[:id]).destroy
    redirect_to current_user 
  end

end