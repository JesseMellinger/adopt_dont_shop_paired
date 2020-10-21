class PetsController < ApplicationController

  def index
    @pets = Pet.get_all_pets
  end

  def show
    @pet = Pet.find_by_id(params[:id])
  end

  def edit
    @pet = Pet.find_by_id(params[:id])
  end

  def update
    pet = Pet.find_by_id(params[:id])
    pet.update({
      image: params[:pet][:image],
      name: params[:pet][:name],
      description: params[:pet][:description],
      approximate_age: params[:pet][:approximate_age],
      sex: params[:pet][:sex]
      })
      pet.save
      redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

end
