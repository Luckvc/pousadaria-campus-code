class Api::V1::InnsController < ActionController::API
  before_action :set_cors_header, only: [:show, :index]

  def show
    begin 
      inn = Inn.find(params[:id]).as_json(except: [:created_at, :updated_at, :cnpj, :company_name]) 
      score = Review.joins(reservation: :room).where("inn_id = ?", inn["id"]).average(:score) 
      inn[:score] = score.to_s
      render status:200, json: inn
    rescue
      return render status: :not_found
    end
  end

  def index
    query = params[:query]
    render status:200, json: Inn.where("name LIKE ? AND active = ?", "%#{query}%", true)
      .as_json(except: [:created_at, :updated_at])
  end

  private

  def set_cors_header
    response.headers['Access-Control-Allow-Origin'] = "http://127.0.0.1:3001"
  end

end