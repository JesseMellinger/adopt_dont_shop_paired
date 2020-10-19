class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def approved?
    status == "approved"
  end
end
