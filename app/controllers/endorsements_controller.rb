class EndorsementsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    review.endorsements.create(user_id: current_user.id)
    redirect_to restaurants_path
  end
end
