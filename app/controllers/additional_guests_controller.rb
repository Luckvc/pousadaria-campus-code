class AdditionalGuestsController < ApplicationController
  before_action :authenticate_user!

  def create
    res = Reservation.find(params[:reservation_id])
    @additional_guest = res.additional_guests.build(params.require(:additional_guest).permit(:name, :document))

    if @additional_guest.save
      redirect_to check_in_reservation_path(res), notice: "Hóspede cadastrado com sucesso"
    else
      flash.now[:notice] = "Não foi possível cadastrar o hóspede"
      render 'admin', status:422
    end
  end
end