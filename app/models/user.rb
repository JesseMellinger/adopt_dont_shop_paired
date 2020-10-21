class User < ApplicationRecord
  has_many :reviews
  has_many :applications

  def average_review_rating
    reviews.average(:rating)
  end

  def best_review
    reviews.order("rating DESC").first
  end

  def worst_review
    reviews.order("rating").first
  end

  def reviews?
    reviews.count > 0
  end

  def self.find_by_name(name)
    User.find_by(name: name)
  end

  def self.find_by_id(id)
    User.find(id)
  end
end
