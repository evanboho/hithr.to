class Users::SessionsController < Devise::SessionsController

  def new
    resource = build_resource
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end


end