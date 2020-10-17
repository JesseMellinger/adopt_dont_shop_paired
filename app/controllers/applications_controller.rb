class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    user = User.find_by(name: params[:user_name])
    application = Application.create(status: "In Progress",
                                     user_id: user.id)

    redirect_to "/applications/#{application.id}"
  end

end
