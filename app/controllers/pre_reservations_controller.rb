class PreReservationsController < ApplicationController

  def new
    @pre_reservation = PreReservation.new
    @room = Room.find(params[:room_id])
  end
end