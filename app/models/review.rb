class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user
end
