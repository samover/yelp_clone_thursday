class EndorsementsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    review.endorsements.create(user_id: current_user.id)
    render json: { new_endorsement_count: review.endorsements.count }
  end
end
