class ShelterReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end
end
