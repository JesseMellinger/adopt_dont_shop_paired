class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    require "pry"; binding.pry
    redirect_to "admin/applications/#{params[:id]}"
  end

end
