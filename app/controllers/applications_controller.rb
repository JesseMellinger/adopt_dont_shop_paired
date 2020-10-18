class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @search_results = Pet.where("name like ?", "%#{params[:search]}%")
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

  def update
    application = Application.find(params[:id])

    if !params[:body].empty?
      application.update(description: params[:body],
                         status: "Pending")

      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Please tell us why you would make a good owner."

      redirect_to "/applications/#{application.id}"
    end

  end

  private
  def application_params
    params.permit(:status, :description)
  end
end
