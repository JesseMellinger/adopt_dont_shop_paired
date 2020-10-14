class ShelterReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    user = User.where(name: params[:name])

    shelter = Shelter.find(params[:id])

    review = Review.new(shelter_review_params)
    review.user_id = user.first.id
    review.shelter_id = shelter.id
    review.save!

    redirect_to "/shelters/#{params[:id]}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :picture, :content)
  end
end
