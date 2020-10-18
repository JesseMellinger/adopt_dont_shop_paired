class PetApplicationsController < ApplicationController

  def create
    PetApplication.create(pet_applications_params)
    
    redirect_to "/applications/#{params[:application_id]}"
  end

  private
  def pet_applications_params
    params.permit(:pet_id, :application_id)
  end

end
