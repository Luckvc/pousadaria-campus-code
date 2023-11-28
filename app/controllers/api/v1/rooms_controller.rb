class Api::V1::RoomsController < ActionController::API

  def index
    begin
      render status:200, json: Inn.find(params[:inn_id]).rooms.as_json(except: [:created_at, :updated_at])
    rescue
      render status:404
    end
  end
end