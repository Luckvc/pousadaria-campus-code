class Api::V1::RoomsController < ActionController::API

  def index
    begin
      render status:200, json: Inn.find(params[:inn_id]).rooms.as_json(except: [:created_at, :updated_at])
    rescue
      render status:404
    end
  end

  def available
    room = Room.find(params[:id])
    pre_reservation = room.pre_reservations.build(params.permit(:check_in_date, :check_out_date, :guests))
    
    if pre_reservation.save
      render status:200, json: pre_reservation.as_json(except: [:created_at, :updated_at])
    else
      render status:200, json: {}
    end
  end
end