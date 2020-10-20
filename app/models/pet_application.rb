class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_application(pet_id, application_id)
    self.all.where("pet_id = ? AND application_id = ?", pet_id, application_id)
  end
end
