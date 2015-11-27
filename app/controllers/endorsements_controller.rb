class EndorsementsController < ApplicationController
  def create
    Endorsement.create(review_id: params[:review_id], user_id: current_user.id)
    #restaurant = Review.find(params[:review_id]).restaurant
    
    redirect_to restaurants_path
  end
end
