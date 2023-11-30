class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_room_and_check_user, only: [:edit, :update]

  def new
    @room = Room.new
  end
  def create
    @inn = current_user.inn
    @room = @inn.rooms.build(room_params)

    if @room.save
      redirect_to my_inn_path, notice: "Quarto registrada com sucesso."
    else
      flash.now[:notice] = "Quarto não cadastrada"
      render 'new', status: 422
    end
  end

  def edit; end
  
  def update
    if @room.update(room_params)
      redirect_to room_path(@room.id), notice: 'Quarto atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o quarto'
      render 'edit', status: 422
    end
  end
  def show
    @room = Room.find(params[:id])
  end
  
  private

  def room_params
    room_params = params.require(:room).permit(:number, :description, :double_beds, :single_beds, 
      :capacity, :price, :price, :bathrooms, :dimension, :kitchen, :balcony, :tv, :air, :wardrobe,
      :safe, :accessible)
  end

  def set_room_and_check_user
    @room = Room.find(params[:id])
    if @room.inn.user.id != current_user.id
      return redirect_to root_path, alert: 'Você não possui acesso a esta reserva'
    end
  end

end