class MessagesController < ApplicationController

  before_filter :current_user?
  before_filter :authenticate_user!

  def get_inbox
    @messages = current_user.messages.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    @messages_sent = Message.sent(current_user).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end
  
  def index
    get_inbox
  end
  def sent
    @messages_sent_all = Message.sent(current_user).paginate(:page => params[:page], :per_page => 10)
    get_inbox
    render 'index'
  end
  def all
    @messages_all = Message.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 10)
    get_inbox
    render 'index'
  end
  
  def show
    get_inbox
    @message = Message.find(params[:id])
    @mutual_messages = Message.where('id <> ?', @message.id).mutual_messages(@message.user, @message.sender)
    @reply = current_user.messages.new
  end
  
  def reply
    get_inbox
    @reply = current_user.messages.new
  end
  
  def new
    get_inbox
    @user = User.find(params[:user_id])
    @message = @user.messages.new
    if params[:reply_from].present?
      @reply_from = Message.find(params[:reply_from])
      unless @reply_from.sujet.split(":").first == "re"
        @message.sujet = "re: " + @reply_from.sujet 
      else
        @message.sujet = @reply_from.sujet
      end
    end
  end
  
  def create
    get_inbox
    @user = User.find(params[:user_id])
    @message = @user.messages.build(params[:message])
    @message.sender_id = current_user.id
    @message.read = false
    if @message.save
      # MessageMailer.send_message(@message).deliver
      flash[:notice] = "Message sent"
      redirect_to @message
    else
      render 'new'
    end
  end
  
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = "done"
      redirect_to user_messages_path(current_user)
    else
      flash[:error] = "oops"
      render 'edit'
    end
  end
  
  def edit
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
    get_inbox
  end
  
  def destroy
    Message.find(params[:id]).destroy
    redirect_to user_messages_path(current_user) 
  end

end