class ShelterReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    user = User.find_by(name: params[:name])

    shelter = Shelter.find(params[:id])

    review = Review.new(shelter_review_params)
    review.user_id = user.id
    review.shelter_id = shelter.id
    review.save!

    redirect_to "/shelters/#{params[:id]}"
  end

  def edit
    @shelter = Shelter.find(params[:id])
    @review = Review.find(params[:review_id])
    @user = User.find(@review.user_id)
  end

  def update
    review = Review.find(params[:review_id])
    user = User.find(review.user_id)
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      name: user.name
      })
    review.save
    redirect_to "/shelters/#{params[:id]}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :picture, :content)
  end
end
