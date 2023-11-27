class ReviewsController < ApplicationController

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
end