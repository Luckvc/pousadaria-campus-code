class ReservationsController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :show, :cancelled]
  before_action :authenticate_user!, only: [:inn_reservations, :admin, :admin_cancelled, :check_in,
                                            :check_out, :check_out_confirm]

  before_action :set_reservation_and_check_customer, only: [:show, :cancelled]
  before_action :set_reservation_and_check_user, only: [:admin, :admin_cancelled, :check_in,
                                                        :check_in_confirm, :check_out, :check_out_confirm]

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
      return redirect_to @reservation, notice: 'Reservas não podem ser canceladas com menos de 7 
        dias do check-in'
    end
    @reservation.cancelled!
    redirect_to @reservation
  end

  def admin_cancelled
    if (Time.zone.now.to_date - @reservation.check_in_date).to_i < 2
      return redirect_to admin_reservation_path(@reservation), notice: 'Reservas só podem ser 
        canceladas pelo dono da pousada após 2 dias de atraso no check-in'
    end
    @reservation.cancelled!
    redirect_to admin_reservation_path(@reservation)
  end
  
  def inn_reservations
    host = current_user
    @reservations = Reservation.joins(room: :inn).where("user_id = ?", host)
  end
  
  def ongoing
    host = current_user.id
    @reservations = Reservation.ongoing.joins(room: :inn).where("user_id = ?", host)
  end

  def admin; end
  
  def check_in
    @additional_guest = AdditionalGuest.new()
  end

  def check_in_confirm
    if (Time.zone.now.to_date - @reservation.check_in_date).to_i < 0
      return redirect_to admin_reservation_path(@reservation), notice: 'É cedo demais para fazer check-in'
    end
    @reservation.ongoing!
    @reservation.checked_in_datetime = DateTime.now
    @reservation.save!
    redirect_to admin_reservation_path(@reservation)
  end

  def check_out
    @payment_methods = []
    @payment_methods << 'Pix' if @reservation.room.inn.pix?
    @payment_methods << 'Cartão de Crédito' if @reservation.room.inn.credit?
    @payment_methods << 'Cartão de Débito' if @reservation.room.inn.debit?
    @payment_methods << 'Dinheiro' if @reservation.room.inn.cash?
    @check_out = Time.zone.now
    if late_checkout?(@reservation)
      @check_out += 1.day
    end
    @total = calculate_total + calculate_consumables
  end

  def check_out_confirm
    @reservation.payment_method = params[:reservation][:payment_method]
    @reservation.total = params[:reservation][:total]
    @reservation.paid = true
    @reservation.completed!
    @reservation.save

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

  def calculate_consumables()
    total_consumables = 0
    @reservation.consumables.each do |consumable|
      total_consumables += consumable.price
    end
    total_consumables
  end

  def calculate_total()
    cd_matches = []
    total = 0

    @reservation.room.custom_dates.each do |cd|
      if range_overlap(@reservation.checked_in_datetime, @check_out , cd.begin, cd.end)
        cd_matches << cd
      end
    end

    (@reservation.checked_in_datetime.to_date...@check_out.to_date).each do |day|
      price = @reservation.room.price
      cd_matches.each do |cd|
        (cd.begin..cd.end).each do |cd_day|
          price = cd.price if cd_day == day
        end
      end
      total += price
    end
    total
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
  end
  
  def late_checkout?(reservation)
    Time.zone.now > reservation.room.inn.check_out_time.to_time
  end
end