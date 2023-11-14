class CustomDatesController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @custom_date = @room.custom_dates.build()
  end
  def create
    cd_params = params.require(:custom_date).permit(:begin, :end, :price_cents)
    @room = Room.find(params[:room_id])
    @custom_date = @room.custom_dates.build(cd_params)

    if @custom_date.save
      redirect_to room_path(@room), notice: 'Preço Sazonal adicionado com sucesso'
    else
      flash.now[:notice] = 'Preço Sazonal não adicionado'
      render 'new', status: 422
    end
  end
end





