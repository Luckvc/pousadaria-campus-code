class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :show, :update]
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
      render 'new'
    end
  end

  def edit; end
  
  def update
    if @room.update(room_params)
      redirect_to room_path(@room.id), notice: 'Quarto atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o quarto'
      render 'edit'
    end
  end
  def show; end
  
  private

  def room_params
    room_params = params.require(:room).permit(:number, :description, :double_beds, :single_beds, 
                                     :capacity, :price_cents, :price_cents, :bathrooms, :kitchen)
  end
  def set_room
    @room = Room.find(params[:id])
  end

end