class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find_pet_application(params[:pet_id], params[:application_id])
    @application = Application.find(params[:application_id])
    if params[:commit] == "Approve Pet"
      @pet_application.update(status: "approved")
      if application_approved?(@application)
        @application.update(status: "Approved")
        redirect_to "/admin/applications/#{params[:application_id]}"
      else
        redirect_to "/admin/applications/#{params[:application_id]}"
      end
    else
      @pet_application.update(status: "rejected")
      @application.update(status: "Rejected")
      redirect_to "/admin/applications/#{params[:application_id]}"
    end
  end

  def application_approved?(application)
    application.pet_applications.all? do |pet_application|
      pet_application.status == "approved"
    end
  end

end
