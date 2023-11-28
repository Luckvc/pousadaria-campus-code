class Api::V1::InnsController < ActionController::API

  def show
    begin 
      render status:200, json: Inn.find(params[:id]).as_json(except: [:created_at, :updated_at, :cnpj, :company_name])
    rescue
      return render status: :not_found
    end
  end

  def index
    @query = params[:query]
    render status:200, json: Inn.where("name LIKE ? AND active = ?", "%#{@query}%", true)
      .as_json(except: [:created_at, :updated_at])
  end
end