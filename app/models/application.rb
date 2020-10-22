class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_application(id)
    Application.find(id)
  end

  def adopt_all_pets
    pets.all.update(adoption_status: "adopted")
  end

  def approved?
    pet_applications.where(status: [nil, "rejected"]).empty?
  end
end
