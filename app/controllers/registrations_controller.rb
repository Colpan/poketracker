class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    resource.email = params[:email] if params[:email]
    if params[:team]
      resource.team = params[:team]
      user = User.find_by(email: params[:email])
      user.team = params[:team]
      user.save
      resource.save
    end
    if !params[:password].blank? && params[:password] == params[:password_confirmation]
      logger.info "Updating password"
      resource.password = params[:password]
      resource.save
    end
    if resource.valid?
      resource.update_without_password(params)
    end
  end
end
