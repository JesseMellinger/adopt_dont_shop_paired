class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    if params[:commit] == "Approve Pet"
      @pet_application = PetApplication.find_pet_application(params[:pet_id], params[:application_id])
      @pet_application.update(status: "approved")
      redirect_to "admin/applications/#{params[:application_id]}"
    else
      redirect_to "admin/applications/#{params[:application_id]}"
    end
  end

end
