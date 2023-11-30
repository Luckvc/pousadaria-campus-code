class CustomDatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation_and_check_user
  
  def new
    @custom_date = @room.custom_dates.build()
  end
  def create
    cd_params = params.require(:custom_date).permit(:begin, :end, :price)
    @custom_date = @room.custom_dates.build(cd_params)

    if @custom_date.save
      redirect_to room_path(@room), notice: 'Preço Sazonal adicionado com sucesso'
    else
      flash.now[:notice] = 'Preço Sazonal não adicionado'
      render 'new', status: 422
    end
  end  
  
  private

  def set_reservation_and_check_user
    @room = Room.find(params[:room_id])
    if @room.inn.user.id != current_user.id
      return redirect_to root_path, alert: 'Você não possui acesso a este quarto'
    end
  end
end





