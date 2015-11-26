class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:notice] = "You have already reviewed this restaurant"
    else
      @review = @restaurant.reviews.new(review_params)
      @review.user = current_user
      @review.save
    end
    redirect_to '/restaurants'
  end



  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
