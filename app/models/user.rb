class User < ApplicationRecord
  has_many :reviews

  def average_review_rating
    reviews.average(:rating)
  end

  def best_review
    reviews.order("rating DESC").first
  end

  def worst_review
    reviews.order("rating").first
  end
end
