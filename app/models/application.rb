class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_application(id)
    Application.find(id)
  end
end
