class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find_application(params[:id])
  end

  def update
    @pet_application = PetApplication.find_pet_application(params[:pet_id], params[:application_id])
    @application = Application.find_application(params[:application_id])
    if params[:commit] == "Approve Pet"
      @pet_application.update(status: "approved")
      if @application.approved?
        @application.update(status: "Approved")
        @application.adopt_all_pets
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

end
