class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name

  def self.find_all_pets_by_shelter_id(id)
    Pet.where("shelter_id = ?", id)
  end

  def on_approved_application?
    applications.any? {|app| app.status == "Approved"}
  end

  def self.pets_on_approved_applications
    Pet.joins(:pet_applications, :applications).where("applications.status = ?", "Approved")
  end

  def self.find_all_pets_by_name(name)
    name ? Pet.where('lower(name) like ?', "%#{name.downcase}%") : Array.new
  end

  def self.get_all_pets
    Pet.all
  end

  def self.find_by_id(id)
    Pet.find(id)
  end
end
