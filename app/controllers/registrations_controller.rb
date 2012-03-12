class RegistrationsController < Devise::RegistrationsController

  
  def new
    resource = build_resource({})
    respond_with resource
  end
  
  def edit
    render :edit
  end
  
  def destroy
    sent_messages = Message.where(:sender_id => resource.id)
    sent_messages.destroy_all
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
  
  # def update
  #   # @user = User.find(params[:id])
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = "success updating profile"
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end
  
  private
  
  
  # def build_resource(*args)
  #     super
  #     if session['devise.omniauth']
  #       @user.apply_omniauth(session['devise.omniauth'])
  #     end
  #   end
end
