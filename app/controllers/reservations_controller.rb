class ReservationsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]
  before_action :set_reservation_and_check_customer, only: [:show, :cancelled]
  before_action :set_reservation_and_check_user, only: [:admin, :admin_cancelled, :check_in]

  def create
    @customer = current_customer
    reserv_params = params.require(:reservation).permit(:check_in_date, :check_out_date, :guests, :total)
    @reservation = @customer.reservations.build(reserv_params)
    
    @room = Room.find(params[:room_id])
    @reservation.room = @room

    if @reservation.save
      redirect_to @reservation, notice: 'Reserva confirmada'
    else
      flash.now[:notice] = "Reserva indisponível"
      redirect_to root_path
    end
  end

  def show; end

  def index
    @reservations = Reservation.where(customer: current_customer)
  end

  def cancelled
    if (@reservation.check_in_date - Date.today).to_i < 7
      return redirect_to @reservation, notice: 'Reservas não podem ser canceladas com menos de 7 dias do check-in'
    end
    @reservation.cancelled!
    redirect_to @reservation
  end

  def admin_cancelled
    @reservation.cancelled!
    redirect_to admin_reservation_path(@reservation)
  end
  
  def inn_reservations
    host = current_user.id
    @reservations = Reservation.joins("INNER JOIN rooms ON rooms.id = reservations.room_id").
    where("inn_id = ?", host)
  end

  def admin; end
  
  def check_in
    @reservation.occurring!
    @reservation.checked_in_datetime = DateTime.now
    @reservation.save!
    redirect_to admin_reservation_path(@reservation)
  end

  private 

  def set_reservation_and_check_customer
    @reservation = Reservation.find(params[:id])
    if @reservation.customer != current_customer
      return redirect_to root_path, alert: 'Você não possui acesso a esta reserva'
    end
  end
  def set_reservation_and_check_user
    @reservation = Reservation.find(params[:id])
    if @reservation.room.inn.user.id != current_user.id
      return redirect_to root_path, alert: 'Você não possui acesso a esta reserva'
    end
  end
end