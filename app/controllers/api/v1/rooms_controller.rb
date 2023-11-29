class Api::V1::RoomsController < ActionController::API
  before_action :set_cors_header, only: [:index, :available]

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
      render status:200, json: pre_reservation.as_json(except: [:created_at, :updated_at, :id])
    else
      render status:200, json: {}
    end
  end

  private

  def set_cors_header
    response.headers['Access-Control-Allow-Origin'] = "http://127.0.0.1:3001"
  end
end