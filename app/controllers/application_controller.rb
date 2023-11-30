class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :lock_to_new_inn

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    if stored_location
      stored_location
    else
      super
    end
  end

  
  protected
  
  def lock_to_new_inn
    if !current_user.nil? && current_user.inn.nil? && !on_new_inn_page?
      redirect_to new_inn_path, notice: 'Por favor, cadastre a sua pousada antes de continuar'
    end
  end

  def on_new_inn_page?
    controller_name == 'inns' && (action_name == 'new' || action_name == 'create')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
  end
end
