class InnController < ApplicationController
  before_action :authenticate_user!

  def new
    @inn = Inn.new
    @inn.build_address
  end
  
  def create
    @user = User.find(current_user.id)
    inn_params = params.require(:inn).permit(:name, :company_name, :cnpj, :phone, :email, 
      address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :cep])
    
    @inn = @user.build_inn(inn_params)

    if @inn.save
      redirect_to my_inn_path, notice: "Pousada registrada com sucesso."
    else
      flash.now[:notice] = "Pousada não cadastrada"
      render 'new'
    end
  end

  def my_inn
    if !current_user.host?
      return redirect_to root_path, notice: 'Para cadastrar pousadas por favor crie uma conta como dono de pousada.'
    end
    if current_user.inn
      @inn = current_user.inn
    else
      redirect_to new_user_inn_path
    end
  end
end