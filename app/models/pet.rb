class Pet < ApplicationRecord
  belongs_to :shelter

  def self.find_all_pets_by_shelter_id(id)
    pets = []
    Pet.all.each do |pet|
      pets << pet if pet.shelter_id.to_s == id
    end
    pets
  end

end
