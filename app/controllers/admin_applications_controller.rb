class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find_pet_application(params[:pet_id], params[:application_id])
    @application = Application.find(params[:application_id])
    if params[:commit] == "Approve Pet"
      @pet_application.update(status: "approved")
      @application.update(status: "Approved") if application_approved?(@application)
      redirect_to "admin/applications/#{params[:application_id]}"
    else
      @pet_application.update(status: "rejected")
      redirect_to "admin/applications/#{params[:application_id]}"
    end
  end

  def application_approved?(application)
    application.pet_applications.all? do |pet_application|
      pet_application.status == "approved"
    end
  end

end
