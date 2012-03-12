class MessagesController < ApplicationController

  def index
    @user = current_user
    message = @user.messages.order('created_at ASC')
    @message = message.where(:read => false)
    @message_read = message.where(:read => true)
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @message = @user.messages.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.build(params[:message])
    @message.sender_id = current_user.id
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
      redirect_to user_messages_path(@message.user)
    else
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