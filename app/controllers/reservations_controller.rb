class ReservationsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]

  def create
    @customer = current_customer
    reserv_params = params.require(:reservation).permit(:check_in_date, :check_out_date, :guests, :total)
    @reservation = @customer.reservations.build(reserv_params)
    
    @room = Room.find(params[:room_id])
    @reservation.room = @room

    if @reservation.save
      redirect_to reservation_path(@reservation), notice: 'Reserva confirmada'
    else
      flash.now[:notice] = "Reserva indisponível"
      redirect_to root_path
    end
  end

  def show
    
  end
end