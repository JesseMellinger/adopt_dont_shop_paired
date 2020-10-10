class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new

  end

  def create

    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

    shelter.save

    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })
      shelter.save
      redirect_to "/shelters/#{shelter.id}"
    end

    def destroy
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end

    def pets
      @pets = Pet.find_all_pets_by_shelter_id(params[:id])
    end

    def new_pet

    end

    def create_pet

      pet = Pet.new({
        image: params[:image],
        name: params[:name],
        approximate_age: params[:approximate_age],
        sex: params[:sex],
        name_of_shelter: Shelter.find(params[:id]).name,
        description: params[:description],
        adoption_status: "adoptable",
        shelter_id: params[:id]
      })

      pet.save

      redirect_to "/shelters/#{params[:id]}/pets"
    end

    private
    def pet_params
      params.permit(:image)
      params.permit(:name)
      params.permit(:approximate_age)
      params.permit(:sex)
      params.permit(:description)
      params.permit(:id)
    end

end
