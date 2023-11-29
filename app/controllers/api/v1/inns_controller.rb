class Api::V1::InnsController < ActionController::API

  def show
    begin 
      inn = Inn.find(params[:id]).as_json(except: [:created_at, :updated_at, :cnpj, :company_name]) 
      score = Review.joins(reservation: :room).where("inn_id = ?", inn["id"]).average(:score) 
      inn[:score] = score.to_s
      inn = set_address(inn)
      render status:200, json: inn
    rescue
      return render status: :not_found
    end
  end

  def index
    query = params[:query]
    inns = Inn.where("name LIKE ? AND active = ?", "%#{query}%", true)
              .as_json(except: [:created_at, :updated_at, :user_id, :cnpj, :company_name])
    inns.each { |inn| inn = set_address(inn)}
    render status:200, json: inns
  end

  private

  def set_address(inn)
    inn[:address] = Address.find(inn["address_id"]).as_json(except: [:id, :created_at, :updated_at])
    inn.delete("address_id")
    inn
  end

end