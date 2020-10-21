class ApplicationsController < ApplicationController

  def show
    @application = Application.find_application(params[:id])
    @search_results = Pet.find_all_pets_by_name(params[:search])
  end

  def new

  end

  def create
    user = User.find_by_name(params[:user_name])
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
    application = Application.find_application(params[:id])

    if !params[:body].empty?
      application.update(description: params[:body],
                         status: "Pending")

      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Please tell us why you would make a good owner."

      redirect_to "/applications/#{application.id}"
    end

  end

end
