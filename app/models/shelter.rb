class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  def number_of_pets
    find_pets_of_shelter().count
  end

  def average_review_rating
    Review.average(:rating)
  end

  def number_of_applications
    pets.reduce(0) do |coll, pet|
      coll += pet.applications.count
      coll
    end
  end

  def has_pets_on_approved_applications?
    pets.any? do |pet|
      pet.on_approved_application?
    end
  end

  def delete_associated_pets
    PetApplication.where(pet_id: find_pets_of_shelter.pluck(:id)).destroy_all
    Pet.destroy(find_pets_of_shelter.pluck(:id))
  end

  def find_pets_of_shelter
    Pet.where("shelter_id = ?", self.id)
  end

  def delete_associated_reviews
    Review.where("shelter_id = ?", self.id).destroy_all
  end

  def self.find_by_id(id)
    Shelter.find(id)
  end

  def self.get_all_shelters
    Shelter.all
  end

end
