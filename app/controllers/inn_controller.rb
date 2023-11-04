class InnController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def my_inn
    if !current_user.host?
      return redirect_to root_path, notice: 'Para cadastrar pousadas por favor crie uma conta como dono de pousada.'
    end
    if current_user.inn
      @inn = current_user.inn
    else
      redirect_to new_address_path
    end
  end
end