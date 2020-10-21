class PetApplicationsController < ApplicationController

  def index
    @pet_applications = PetApplication.find_all_by_pet_id(params[:pet_id])
  end

  def create
    pet_application = PetApplication.create(pet_applications_params)

    redirect_to "/applications/#{params[:application_id]}"
  end

  private
  def pet_applications_params
    params.permit(:pet_id, :application_id, :status)
  end

end
