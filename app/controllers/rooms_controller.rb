class RoomsController < ApplicationController
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
  def edit
    @room = Room.find(params[:id])
  end
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to my_inn_path, notice: 'Quarto atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o quarto'
      render 'edit'
    end
  end
  
  private

  def room_params
    room_params = params.require(:room).permit(:number, :description, :double_beds, :single_beds, 
                                     :capacity, :price_cents, :price_cents, :bathrooms, :kitchen)
  end

end