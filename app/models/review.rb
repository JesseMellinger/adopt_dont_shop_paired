class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates_presence_of :title, :rating, :content

  def self.find_by_id(id)
    Review.find(id)
  end
end
