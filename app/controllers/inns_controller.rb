class InnsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my_inn, :edit, :update, :change_status, 
                                            :deactivate, :activate]

  before_action :set_inn, only: [:show, :reviews]
  before_action :set_inn_and_check_user, only: [:edit, :update, :change_status, :deactivate,
                                                :activate, :new_image, :create_image]

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
    @inns = Inn.joins(:address).
      where("name LIKE ? OR neighborhood LIKE ? OR city LIKE ? AND active = ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", true).
      order(:name)
    @count = @inns.count
  end
  
  def cities
    @cities = Address.distinct.pluck(:city)
  end
  
  def search_cities
    @query = params["query"]
    @inns = Inn.joins(:address).where("city = ? AND active = ?", "#{@query}", true)
    @count = @inns.count
  end
  
  def advanced_search 
    rooms = Room.joins(:inn).where("name LIKE ?", "%#{params["query"]}%")
    #TODO
    rooms = rooms.where("safe = 1") if params["safe"].to_i == 1
    rooms = rooms.where("air = 1") if params["air"].to_i == 1
    rooms = rooms.where("wardrobe = 1") if params["wardrobe"].to_i == 1
    rooms = rooms.where("balcony = 1") if params["balcony"].to_i == 1
    rooms = rooms.where("tv = 1") if params["tv"].to_i == 1
    rooms = rooms.where("kitchen = 1") if params["kitchen"].to_i == 1
    rooms = rooms.where("accessible = 1") if params["accessible"].to_i == 1
    rooms = rooms.where("capacity >= ?", params["capacity"]) if params["capacity"].present?
    
    filtered_room_ids = rooms.pluck(:id) 
    @inns = Inn.joins(:rooms).where(rooms: { id: filtered_room_ids }).distinct
    
    @inns = @inns.where("pets = 1") if params["pets"].to_i == 1
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

  def new_image; end

  def create_image
    if @inn.update(inn_params)
      redirect_to my_inn_path, notice: 'Imagens adicionadas com sucesso'
    else
      flash.now[:notice] = 'Não foi possível adicionar as imagens'
      render :my_inn, status: 422
    end
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
                               images: [],
      address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :cep])
  end

  def set_inn
    @inn = Inn.find(params[:id])
  end
end