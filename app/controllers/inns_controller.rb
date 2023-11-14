class InnsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :my_inn]
  before_action :set_inn, only: [:show, :edit, :update]

  def show
  end

  def new
    @inn = Inn.new
    @inn.build_address
  end
  
  def create
    @user = current_user
    @inn = @user.build_inn(inn_params)

    if @inn.save
      redirect_to my_inn_path, notice: "Pousada registrada com sucesso."
    else
      flash.now[:notice] = "Pousada não cadastrada"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @inn.update(inn_params)
      redirect_to my_inn_path, notice: 'Pousada atualizada com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar a pousada'
      render 'edit'
    end
  end

  def my_inn
    if !current_user.host?
      return redirect_to root_path, notice: 'Para cadastrar pousadas por favor crie uma conta como 
                                             dono de pousada.'
    end
    if current_user.inn
      @inn = current_user.inn
    else
      redirect_to new_inn_path
    end
  end

  def search
    @query = params["query"]
    @inns = Inn.joins("INNER JOIN addresses ON addresses.id = inns.address_id").
      where("name LIKE ? OR neighborhood LIKE ? OR city LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%").
      order(:name)
    @count = @inns.count
  end
  
  def cities
    @cities = Address.distinct.pluck(:city)
  end
  
  def search_cities
    @query = params["query"]
    @inns = Inn.joins("INNER JOIN addresses ON addresses.id = inns.address_id").where("city = ?", "#{@query}")
    @count = @inns.count
  end
  
  private
  
  def inn_params
    inn_params = params.require(:inn).permit(:name, :company_name, :cnpj, :phone, :email, 
      address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :cep])
  end

  def set_inn
    @inn = Inn.find(params[:id])
  end
end