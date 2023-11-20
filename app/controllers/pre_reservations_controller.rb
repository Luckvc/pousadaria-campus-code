class PreReservationsController < ApplicationController

  def new
    @pre_reservation = PreReservation.new
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    pr_params = params.require(:pre_reservation).permit(:check_in_date, :check_out_date, :guests)
    @pre_reservation = @room.pre_reservations.build(pr_params)
    
    if @pre_reservation.save
      redirect_to pre_reservation_confirmation_path(@pre_reservation)
    else
      flash.now[:notice] = "Reserva indisponível"
      render 'new', status: 422
    end
  end

  def confirmation
    @pre_reservation = PreReservation.find(params[:pre_reservation_id])
    @reservation = Reservation.new()
    store_location_for(:customer, pre_reservation_confirmation_path(@pre_reservation))
  end
end