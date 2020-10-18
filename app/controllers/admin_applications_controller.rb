class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(param[:id])
  end

end
