class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name

  def self.find_all_pets_by_shelter_id(id)
    Pet.where("shelter_id = ?", id)
  end

end
