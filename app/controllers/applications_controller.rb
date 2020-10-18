class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @search_results = Pet.where(name: params[:search])
  end

  def new

  end

  def create
    user = User.find_by(name: params[:user_name])
    application = Application.new(status: "In Progress")

    if user
      application.user_id = user.id
      application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "User could not be found"
      redirect_to "/applications/new"
    end

  end

  private
  def application_params
    params.permit(:status)
  end
end
