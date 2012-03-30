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
  
  def after_update_path_for(resource)
    resource
  end

end
