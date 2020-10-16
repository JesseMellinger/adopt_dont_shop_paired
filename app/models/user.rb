class User < ApplicationRecord
  has_many :reviews

  def average_review_rating
    reviews.average(:rating)
  end
end
