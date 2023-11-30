class InnsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my_inn, :edit, :update, :change_status, 
                                            :deactivate, :activate]

  before_action :set_inn, only: [:show, :reviews]
  before_action :set_inn_and_check_user, only: [:edit, :update, :change_status, :deactivate, :activate]

  def show
    @score = Review.joins(reservation: :room).where("inn_id = ?", @inn.id).average(:score)
    @reviews = Review.joins(reservation: :room).where("inn_id = ?", @inn.id).last(3)
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
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    if @inn.update(inn_params)
      redirect_to my_inn_path, notice: 'Pousada atualizada com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar a pousada'
      render :edit, status: 422
    end
  end

  def my_inn
   if current_user.inn
      @inn = current_user.inn
    else
      redirect_to new_inn_path
    end
  end

  def search
    @query = params["query"]
    @inns = Inn.joins("INNER JOIN addresses ON addresses.id = inns.address_id").
      where("name LIKE ? OR neighborhood LIKE ? OR city LIKE ? AND active = ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", true).
      order(:name)
    @count = @inns.count
  end
  
  def cities
    @cities = Address.distinct.pluck(:city)
  end
  
  def search_cities
    @query = params["query"]
    @inns = Inn.joins("INNER JOIN addresses ON addresses.id = inns.address_id").where("city = ? AND active = ?", "#{@query}", true)
    @count = @inns.count
  end

  def change_status
  end

  def deactivate
    @inn.active = false
    @inn.save
    redirect_to my_inn_path, notice:'Pousada desativada'
  end

  def activate
    @inn.active = true
    @inn.save
    redirect_to my_inn_path, notice:'Pousada reativada'
  end

  def reviews
    @reviews = Review.joins(reservation: :room).where("inn_id = ?", @inn.id)
  end

  private

  def set_inn_and_check_user
    @inn = Inn.find(params[:id])
    if @inn.user.id != current_user.id
      return redirect_to root_path, alert: 'Você não possui acesso a este quarto'
    end
  end

  def inn_params
    inn_params = params.require(:inn).permit(:name, :company_name, :cnpj, :phone, :email, :policies,
                               :check_in_time, :check_out_time, :pets, :pix, :credit, :debit, :cash,
      address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :cep])
  end

  def set_inn
    @inn = Inn.find(params[:id])
  end
end