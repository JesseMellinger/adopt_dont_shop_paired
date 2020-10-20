class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_application(pet_id, application_id)
    self.all.find_by("pet_id = ? AND application_id = ?", pet_id, application_id)
  end
end
