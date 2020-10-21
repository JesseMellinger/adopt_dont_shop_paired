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
    Shelter.joins(pets: [:applications]).count
  end
end
