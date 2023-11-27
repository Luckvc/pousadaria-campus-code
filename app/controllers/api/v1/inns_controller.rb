class Api::V1::InnsController < ActionController::API

  def show
    begin 
      inn = Inn.find(params[:id])
      render status:200, json: inn.as_json(except: [:created_at, :updated_at])
    rescue
      return render status: :not_found
    end
  end
end