class ConsumablesController < ApplicationController
  before_action :authenticate_user!
  def new
    @res = Reservation.find(params[:reservation_id])
    @consumable = Consumable.new
  end
  
  def create
    @res = Reservation.find(params[:reservation_id])
    @consumable = @res.consumables.build(params.require(:consumable).permit(:description, :price))

    if @consumable.save
      redirect_to admin_reservation_path(@res), notice: "Consumo cadastrado com sucesso"
    else
      flash.now[:notice] = "Não foi possível cadastrar consumo"
      render :new, status: 422
    end
  end
end