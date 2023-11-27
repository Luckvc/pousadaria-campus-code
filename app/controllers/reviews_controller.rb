class ReviewsController < ApplicationController
  before_action :set_review_and_check_customer, only: [:create]
  before_action :set_review_and_check_user, only: [:answer]

  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new
  end

  def create
    @customer = current_customer
    @reservation = Reservation.find(params[:reservation_id])
    review_params = params.require(:review).permit(:score, :message)
    @review = @reservation.build_review(review_params)
    
    @review.customer = current_customer
    if @review.save
      redirect_to @reservation, notice: 'Avaliação registrada'
    else
      flash.now[:notice] = "Avaliação não registrada"
      redirect_to root_path
    end
  end

  def index
    host = current_user.id
    @reviews = Review.joins(reservation: {room: :inn}).where("user_id = ?", host)
  end

  def answer
    @review.answer = params[:review][:answer]
    if @review.save && !@review.answer.empty?
      redirect_to reviews_path, notice: 'Avaliação Respondida'
    else
      redirect_to reviews_path, notice: 'Resposta inválida'
    end
  end
end


private 

def set_review_and_check_customer
  @review = Review.find(params[:id])
  if @review.reservation.customer != current_customer
    return redirect_to root_path, alert: 'Você não possui acesso a esta reserva'
  end
end

def set_review_and_check_user
  @review = Review.find(params[:id])
  if @review.reservation.room.inn.user.id != current_user.id
    return redirect_to root_path, alert: 'Você não possui acesso a esta reserva'
  end
end