class FavoritesController < ApplicationController

  def index
    @approved_pets = Pet.pets_on_approved_applications
  end

end
