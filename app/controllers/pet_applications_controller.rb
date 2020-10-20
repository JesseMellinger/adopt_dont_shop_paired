class PetApplicationsController < ApplicationController

  def create
    pet_application = PetApplication.create(pet_applications_params)
    pet_application.update(status: "rejected")

    redirect_to "/applications/#{params[:application_id]}"
  end

  private
  def pet_applications_params
    params.permit(:pet_id, :application_id)
  end

end
