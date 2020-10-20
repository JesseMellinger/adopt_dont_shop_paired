class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find_pet_application(params[:pet_id], params[:application_id])
    if params[:commit] == "Approve Pet"
      @pet_application.update(status: "approved")
      redirect_to "admin/applications/#{params[:application_id]}"
    else
      @pet_application.update(status: "rejected")
      redirect_to "admin/applications/#{params[:application_id]}"
    end
  end

end
