class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  def number_of_pets
    Pet.where("shelter_id = ?", self.id).count
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

end
