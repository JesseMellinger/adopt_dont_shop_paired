class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: params[:id])
    @average_review_rating = @user.average_review_rating.to_f.round(1)
  end

  def new

  end

  def create
    user = User.create(user_params)

    redirect_to "/users/#{user.id}"
  end

  private
  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
